/*!
 * ImHex pattern for N64 GameShark ROM files (firmware dumps).
 * Supports all known GameShark firmware versions
 * (tested on v1.02 through v3.30).
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-04-26
 * @license MIT
 */

#pragma MIME application/x-n64-gameshark-rom

#include <type/magic.pat>
#include <type/size.pat>
#include <type/time.pat>

#include <std/array.pat>
#include <std/core.pat>
#include <std/ctype.pat>
#include <std/hash.pat>
#include <std/math.pat>
#include <std/mem.pat>
#include <std/string.pat>
#include <std/sys.pat>
#include <std/time.pat>

/*******************************************************************************
 * Type aliases
 ******************************************************************************/

using Array<Type, auto Len> = std::Array<Type, Len>;
using Bytes<auto Len>       = std::mem::Bytes<Len>;

/*******************************************************************************
 * Constants
 ******************************************************************************/

// white
#define COLOR_MAGIC     color("FFFFFF")

// green
#define COLOR_TIMESTAMP color("00FF00")

// dark gray
#define COLOR_UNKNOWN   color("555555")

// red
#define COLOR_IMPORTANT color("FF0000")

// yellow
#define COLOR_HIGHLIGHT color("FFFF00")

// blue
#define COLOR_LOWLIGHT  color("0000FF")

// green
#define COLOR_PRIMARY   color("00FF00")

#define FORMAT_BYTES    format_read("format_bytes")

str HEADER_MAGIC_1 = "\x80\x37\x12\x40\x00\x00\x00\x0F";
str HEADER_MAGIC_2 = "\x00\x00\x14\x44";

/*******************************************************************************
 * Utility functions
 ******************************************************************************/

fn assert(bool condition, str message, auto ... params) {
    std::assert(condition, std::format(message, params));
};

fn assert_magic_str(auto actual, auto expected) {
    assert(actual == expected, "Invalid magic header value! Expected \"{}\", got \"{}\".", expected, actual);
};

fn find(u32 startAddr, u32 endAddr, auto ... bytes) {
    u32 addr = std::mem::find_sequence_in_range(
        /* occurrence_index = */ 0,
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ endAddr,
        /* bytes            = */ bytes
        );
    return addr;
};

fn bytes_to_u32(auto bytes) {
    return (bytes[3] << 24)
         | (bytes[2] << 16)
         | (bytes[1] <<  8)
         | (bytes[0]);
};

fn read_u32_at(u32 addr) {
    return std::mem::read_unsigned(addr, 4);
};

fn read_next_byte() {
    return std::mem::read_unsigned($, 1);
};

fn is_null() {
    return read_next_byte() == 0;
};

fn is_digit() {
    return std::ctype::isdigit(read_next_byte());
};

fn is_version_char() {
    u8 b = read_next_byte();
    return std::ctype::isalnum(b) || b == '.';
};

fn is_iso_date_char() {
    u8 b = read_next_byte();
    return (b >= '0' && b <= '9') || b == '-';
};

fn is_printable_char() {
    u8 b = read_next_byte();
    return b >= ' ' && b <= '~';
};

fn parse_int(auto s) {
    return std::string::parse_int(s, 10);
};

fn parse_float(auto s) {
    return std::string::parse_float(s);
};

fn strlen(auto s) {
    return std::string::length(s);
};

fn format_bytes(auto bytes) {
    u32 i = 0;
    u32 len = sizeof(bytes);
    if (len == 0) {
        return "";
    }
    str fmt;
    while (i < len) {
        fmt += std::format(" {:02X}", u8(bytes[i]));
        i += 1;
    }
    return std::string::substr(fmt, 1, std::string::length(fmt));
};

/*******************************************************************************
 * Header section
 ******************************************************************************/

enum BgPattern : u8 {
    SILK  = 0x00,
    ROCK  = 0x01,
    SHARK = 0x02,
};

enum BgColor : u8 {
    GREY   = 0x00, // [[color("555555")]]
    TAN    = 0x01, // [[color("D2B48C")]]
    BLUE   = 0x02, // [[color("0000FF")]]
    GREEN  = 0x03, // [[color("00FF00")]]
    PINK   = 0x04, // [[color("FFC0CB")]]
    YELLOW = 0x05, // [[color("FFFF00")]]
    RED    = 0x06, // [[color("FF0000")]]
};

fn parse_month(str MMM) {
    // TODO(CheatoBaggins): Find a more idiomatic way to do this.
    if (MMM == "Jan") { return 1; }
    if (MMM == "Feb") { return 2; }
    if (MMM == "Mar") { return 3; }
    if (MMM == "Apr") { return 4; }
    if (MMM == "May") { return 5; }
    if (MMM == "Jun") { return 6; }
    if (MMM == "Jul") { return 7; }
    if (MMM == "Aug") { return 8; }
    if (MMM == "Sep") { return 9; }
    if (MMM == "Oct") { return 10; }
    if (MMM == "Nov") { return 11; }
    if (MMM == "Dec") { return 12; }
    return -1;
};

struct BuildTimestamp {
    str headerId = std::mem::read_string(0x20, 0x20);
    bool isPerfectTrainer = std::string::starts_with(headerId, "Perfect Trainer 2003 iCEMARi0");

    if (isPerfectTrainer) {
        u16 year  = 2003;
        u8 month  = 06;
        u8 day    = 18;
        u8 hour   = 00;
        u8 minute = 00;
    } else {
        char HH[2];
        char [[hidden]];
        char mm[2];
        char [[hidden]];
        char MMM[3];
        char [[hidden]];
        char dd[while(is_digit())];
        char [[hidden]];
        char yy[while(is_digit())];

        bool hasYear = strlen(yy) > 0;

        u16 year  = hasYear ? parse_int("19" + yy) : 2000;
        u8 month  = parse_month(MMM);
        u8 day    = parse_int(dd);
        u8 hour   = parse_int(HH);
        u8 minute = parse_int(mm);
    }

    str id  = std::format("{:04d}{:02d}{:02d}T{:02d}{:02d}",    year, month, day, hour, minute);
    str iso = std::format("{:04d}-{:02d}-{:02d}T{:02d}:{:02d}", year, month, day, hour, minute);
} [[COLOR_TIMESTAMP, format_read("format_header_build_timestamp")]];

fn format_header_build_timestamp(BuildTimestamp bts) {
    return bts.iso;
};

enum FirmwareBrand : u32 {
    UNKNOWN_BRAND,
    GAMESHARK,
    ACTION_REPLAY,
    PERFECT_TRAINER,
    LIBRESHARK,
};

struct HeaderSection {
    u32 startAddr = $;

    char magic1[8]                    [[COLOR_MAGIC,     FORMAT_BYTES]]; assert_magic_str(magic1, HEADER_MAGIC_1);
    u8 mysteriousKeyCodeTailBytes[4]  [[COLOR_IMPORTANT, FORMAT_BYTES]];
    char magic2[4]                    [[COLOR_MAGIC,     FORMAT_BYTES]]; assert_magic_str(magic2, HEADER_MAGIC_2);
    u8 ipl3ChunkCrc32[4]              [[COLOR_HIGHLIGHT, FORMAT_BYTES]];
    u8 gsFwChunkCrc32[4]              [[COLOR_HIGHLIGHT, FORMAT_BYTES]];
    u8 activeKeyCodePrefix[8] @ $ - 8 [[COLOR_HIGHLIGHT, FORMAT_BYTES]];
    padding[8];
    char manufacturerName[16]         [[COLOR_LOWLIGHT]];
    BuildTimestamp buildTimestamp;
    u8 unknownBytes[0x40 - $]         [[COLOR_UNKNOWN,   FORMAT_BYTES]];

    bool isV1or2 = manufacturerName == "(C) DATEL D&D NU";
    bool isV3Pro = manufacturerName == "(C) MUSHROOM &NU";
    bool isTrain = manufacturerName == "Perfect Trainer ";

    FirmwareBrand firmwareBrand = FirmwareBrand::UNKNOWN_BRAND;
    double firmwareVersion = 0.00;
    str firmwareDisambiguator = "";

    if (isTrain) {
        firmwareBrand = FirmwareBrand::PERFECT_TRAINER;
        firmwareVersion = 1.0;
        firmwareDisambiguator = "b";
    }

    match (buildTimestamp.id) {
        ("19980415T1456"): {
            firmwareBrand = FirmwareBrand::ACTION_REPLAY;
            firmwareVersion = 1.11;
        }
        ("19990324T1550"): {
            firmwareBrand = FirmwareBrand::ACTION_REPLAY;
            firmwareVersion = 3.00;
        }
        ("20000418T1608"): {
            firmwareBrand = FirmwareBrand::ACTION_REPLAY;
            firmwareVersion = 3.30;
        }
        ("19970801T1250"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.02;
        }
        ("19970819T1035"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.04;
        }
        ("19970904T1625"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.05;
            firmwareDisambiguator = "Thursday";
        }
        ("19970905T1351"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.05;
            firmwareDisambiguator = "Friday";
        }
        ("19970919T1425"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.06;
        }
        ("19971107T1024"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.07;
        }
        ("19971124T1158"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.08;
            firmwareDisambiguator = "November";
        }
        ("19971208T1110"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.08;
            firmwareDisambiguator = "December";
        }
        ("19980105T1740"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 1.09;
        }
        ("19980305T0806"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 2.00;
            firmwareDisambiguator = "March";
        }
        ("19980406T1005"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 2.00;
            firmwareDisambiguator = "April";
        }
        ("19980825T1357"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 2.10;
        }
        ("19981218T1247"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 2.21;
        }
        ("19990504T1258"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 2.50;
        }
        ("19990401T1505"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 3.00;
        }
        ("19990609T1650"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 3.10;
        }
        ("19990622T1845"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 3.20;
        }
        ("20000104T1426"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 3.21;
        }
        ("20000327T0954"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 3.30;
            firmwareDisambiguator = "March";
        }
        ("20000404T1556"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 3.30;
            firmwareDisambiguator = "April";
        }
        ("20000504T1258"): {
            firmwareBrand = FirmwareBrand::GAMESHARK;
            firmwareVersion = 2.50;
        }
    }

    assert(isV1or2 || isV3Pro || isTrain, "Invalid manufacturer name: \"{}\".", manufacturerName);
} [[format_read("format_header_section")]];

fn format_header_section(HeaderSection hdr) {
    return std::format(
        "Built on \"{}\". Active key code: \"{}  {}  {}\".",
        hdr.buildTimestamp,
        hdr.ipl3ChunkCrc32,
        hdr.gsFwChunkCrc32,
        hdr.mysteriousKeyCodeTailBytes);
};

/*******************************************************************************
 * Firmware section
 ******************************************************************************/

struct RspSwVerDate {
    char MM[2];
    char dash1 [[hidden]];
    char dd[2];
    char dash2 [[hidden]];
    char yy[2];

    u16 year = parse_int("19" + yy);
    u8 month = parse_int(MM);
    u8 day   = parse_int(dd);

    str iso = std::format("{}-{:02d}-{:02d}", year, month, day);
} [[COLOR_TIMESTAMP, format_read("format_rspswverdate")]];

fn format_rspswverdate(RspSwVerDate date) {
    return date.iso;
};

struct FirmwareSection {
    u32 startAddr = $;
    u32 approxEndAddr = startAddr + 0x0002D000;

    u32 titleAddr = find(
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ approxEndAddr,
        /* bytes            = */ 'N','6','4',' ',
                                 'G','a','m','e','S','h','a','r','k',' ',
                                 'V','e','r','s','i','o','n',' '
        );

    u32 rspSwVersionAddr = find(
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ approxEndAddr,
        /* bytes            = */ 'R','S','P',' ','S','W',' ',
                                 'V','e','r','s','i','o','n',':',' '
        );

    double versionNumber = 0.00;

    if (titleAddr != 0xFFFFFFFF) {
        char mainMenuTitle[]   @ titleAddr      [[COLOR_HIGHLIGHT]];
        char mainMenuVersion[] @ titleAddr + 22 [[COLOR_IMPORTANT]];

        versionNumber = parse_float(mainMenuVersion);

        std::print("Main Menu title version: v{}", versionNumber);
    } else {
        std::print("Main Menu title version: UNKNOWN (firmware is compressed; unable to read UI strings)");
    }

    if (rspSwVersionAddr != 0xFFFFFFFF) {
        char rspSwVerNumStr[while(is_version_char())]    @ rspSwVersionAddr + 0x10                                   [[COLOR_HIGHLIGHT]];
        RspSwVerDate rspSwVerDateStr                     @ addressof(rspSwVerNumStr)  + sizeof(rspSwVerNumStr)  +  2 [[format_read("format_rspswverdate")]];
        char sgiU64GfxSwTeam[while(is_printable_char())] @ addressof(rspSwVerDateStr) + sizeof(rspSwVerDateStr) + 22 [[COLOR_IMPORTANT]];
    }
};

/*******************************************************************************
 * User Config section
 ******************************************************************************/

struct UserConfigSection {
    str magicStr = std::mem::read_string($, 2);
    bool isPristine = magicStr == "\xFF\xFF";
    bool isModified = magicStr == "GT";

    if (isModified) {
        char magic[2];
        bool isSoundOn;
        BgPattern bgPattern;
        BgColor bgColor;
        u8 selectedGameIndexStartingAt1; // 0 = no game; 1...255 = game index starting at 1
        u8 unknown1    [[COLOR_UNKNOWN]];
        bool isBackgroundScrollOn;
        u8 unknown2[2] [[COLOR_UNKNOWN]];
        u8 unknown3    [[COLOR_UNKNOWN]];
        padding[0x61];
        bool isMenuScrollOn;

        // TODO(CheatoBaggins): Why doesn't this change the color in the ImHex UI?
        if (bgColor == BgColor::GREY  ) { std::core::set_pattern_color(bgColor, 0x555555FF); }
        if (bgColor == BgColor::TAN   ) { std::core::set_pattern_color(bgColor, 0xD2B48CFF); }
        if (bgColor == BgColor::BLUE  ) { std::core::set_pattern_color(bgColor, 0x0000FFFF); }
        if (bgColor == BgColor::GREEN ) { std::core::set_pattern_color(bgColor, 0x00FF00FF); }
        if (bgColor == BgColor::PINK  ) { std::core::set_pattern_color(bgColor, 0xFFC0CBFF); }
        if (bgColor == BgColor::YELLOW) { std::core::set_pattern_color(bgColor, 0xFFFF00FF); }
        if (bgColor == BgColor::RED   ) { std::core::set_pattern_color(bgColor, 0xFF0000FF); }
    } else if (isPristine) {
        // Brand new cart with factory settings.
        Bytes<0x6D> uninitialized;
    } else {
        // v2.21 and earlier do not have a user config section.
        Bytes<0x00> notPresent;
    }
};

/*******************************************************************************
 * Game List section
 ******************************************************************************/

enum OpCode : u8 {
    REPEATER                       = 0x50,
    WRITE_1B_CONTINUOUS_CACHED     = 0x80,
    WRITE_2B_CONTINUOUS_CACHED     = 0x81,
    WRITE_1B_CONTINUOUS_UNCACHED   = 0xA0,
    WRITE_2B_CONTINUOUS_UNCACHED   = 0xA1,
    WRITE_1B_GS_BUTTON             = 0x88,
    WRITE_2B_GS_BUTTON             = 0x89,
    WRITE_1B_ON_BOOT               = 0xF0,
    WRITE_2B_ON_BOOT               = 0xF1,
    CONDITIONAL_1B_EQ              = 0xD0,
    CONDITIONAL_2B_EQ              = 0xD1,
    CONDITIONAL_1B_NEQ             = 0xD2,
    CONDITIONAL_2B_NEQ             = 0xD3,
    DISABLE_EXPANSION_PAK_METHOD_1 = 0xEE,
    DISABLE_EXPANSION_PAK_METHOD_3 = 0xCC,
    DISABLE_EXPANSION_PAK_METHOD_2 = 0xDD,
    SET_EXE_ENTRY_POINT_ADDR       = 0xDE,
    SET_CODE_STORE_ADDR            = 0xFF,
};

struct Code {
    OpCode opcode;
    u8 address[3] [[format_read("format_code_address")]];
    u8 value[2]   [[format_read("format_code_value")]];
} [[COLOR_IMPORTANT, format_read("format_code")]];

fn format_code(Code code) {
    return std::format(
        "{} {}",
        u8(code.opcode),
        code.address,
        code.value);
};

fn format_code_address(auto addr) {
    return std::format(
        "{:02X}{:02X}{:02X}",
        addr[0],
        addr[1],
        addr[2]);
};

fn format_code_value(auto value) {
    return std::format(
        "{:02X}{:02X}",
        value[0],
        value[1]);
};

bitfield CodeCount {
    bool isCheatEnabled : 1 [[COLOR_LOWLIGHT]];
    unsigned numCodes   : 7 [[COLOR_LOWLIGHT]];
} [[COLOR_LOWLIGHT, format_read("format_cheat_code_count")]];

fn format_cheat_code_count(CodeCount ccc) {
    return std::format(
        "{} {}, {}",
        ccc.numCodes,
        ccc.numCodes == 1 ? "code" : "codes",
        ccc.isCheatEnabled ? "ENABLED by default" : "DISABLED by default");
};

struct Cheat {
    char name[] [[COLOR_PRIMARY]];
    CodeCount codeCount;
    Array<Code, codeCount.numCodes> codes;
} [[format_read("format_cheat")]];

fn format_cheat(Cheat cheat) {
    return std::format(
        "\"{}\" ({})",
        cheat.name,
        cheat.codeCount);
};

struct Game {
    char name[]   [[COLOR_PRIMARY]];
    u8 cheatCount [[COLOR_LOWLIGHT]];
    Array<Cheat, cheatCount> cheats;
}; // [[format_read("format_game")]];

fn format_game(Game game) {
    return std::format(
        "\"{}\" ({} {})",
        game.name,
        game.cheatCount,
        game.cheatCount == 1 ? "cheat" : "cheats");
};

struct GameListSection {
    // Perfect Trainer
    if (std::mem::read_string($, 0x08) == "No Codes") {
        char noCodesMessage[8];
    }
    // Standard GS/AR ROM
    else {
        padding[2];
        u16 gameCount [[COLOR_LOWLIGHT]];
        u32 len = gameCount < 250 ? gameCount : 0;
        Array<Game, len> games;
    }
}; // [[format_read("format_game_list")]];

fn format_game_list(GameListSection gameList) {
    return std::format("{} games", gameList.gameCount);
};

/*******************************************************************************
 * Key Code List section
 ******************************************************************************/

fn is_active_key_code(auto ipl3ChunkCrc32, auto gsFwChunkCrc32) {
    return read_u32_at(0x00000010) == bytes_to_u32(ipl3ChunkCrc32) &&
           read_u32_at(0x00000014) == bytes_to_u32(gsFwChunkCrc32);
};

struct KeyCodeOption<auto Len, auto MaxAddr> {
    assert(Len >= 9 && Len <= 13, "Key Code length must be 9-13 bytes, but found {}.", Len);

    // The IPL3 chunk initiates communication between the game cart's CIC
    // and the N64 console's PIF. The console **will not boot the game**
    // (or in this case the GS ROM, which the N64 _thinks_ is the game)
    // main code until the CIC/PIF link is established.
    // If the PIF ever gets the wrong response from the CIC, it immediately
    // terminates CPU execution and the console hangs until it is power cycled
    // (physically turned off and then on).
    //
    // Q1: Does each GS version have a different IPL3 chunk?
    //     How many bytes is it, and what's its address in ROM/RAM?
    //
    // Q2:
    u8 ipl3ChunkCrc32[4]            [[COLOR_HIGHLIGHT, FORMAT_BYTES]];

    // Checksum of the GS firmware chunk of the GS ROM file???
    u8 gsFwChunkCrc32[4]            [[COLOR_HIGHLIGHT, FORMAT_BYTES]];

    // TODO(CheatoBaggins): What are these bytes used for?
    u8 mysteriousTailBytes[Len - 8] [[COLOR_IMPORTANT, FORMAT_BYTES]];

    char name[]                     [[COLOR_PRIMARY]];

    bool isActive = is_active_key_code(ipl3ChunkCrc32, gsFwChunkCrc32);
    std::print("Key code: \"{}\"{}", name, isActive ? " (ACTIVE)" : "");

    padding[while($ < MaxAddr && is_null())];
} [[format_read("format_key_code_option")]];

fn format_key_code_option(auto keyCode) {
    return std::format(
        "{} {} {}: \"{}\"{}",
        keyCode.ipl3ChunkCrc32,
        keyCode.gsFwChunkCrc32,
        keyCode.mysteriousTailBytes,
        keyCode.name,
        keyCode.isActive ? " (ACTIVE)" : ""
        );
};

struct KeyCodeListSection {
    u32 startAddr = $;
    u32 endAddr = startAddr + 0xA0;

    u32 marioAddr = find(
        /* offsetFrom = */ startAddr,
        /* offsetTo   = */ endAddr,
        /* bytes      = */ 'M','a','r','i','o',' ',
                           'W','o','r','l','d',' ',
                           '6','4',' ','&',' ',
                           'O','t','h','e','r','s'
        );
    u32 diddyAddr = find(
        /* offsetFrom = */ startAddr,
        /* offsetTo   = */ endAddr,
        /* bytes      = */ 'D','i','d','d','y'
        );
    u32 yoshiAddr = find(
        /* offsetFrom = */ startAddr,
        /* offsetTo   = */ endAddr,
        /* bytes      = */ 'Y','o','s','h','i'
        );
    u32 zeldaAddr = find(
        /* offsetFrom = */ startAddr,
        /* offsetTo   = */ endAddr,
        /* bytes      = */ 'Z','e','l','d','a'
        );

    u8 keyCodeLen = marioAddr - startAddr;
    u8 numKeyCodes = 0;

    if (marioAddr != 0xFFFFFFFF) { numKeyCodes += 1; }
    if (diddyAddr != 0xFFFFFFFF) { numKeyCodes += 1; }
    if (yoshiAddr != 0xFFFFFFFF) { numKeyCodes += 1; }
    if (zeldaAddr != 0xFFFFFFFF) { numKeyCodes += 1; }

    KeyCodeOption<keyCodeLen, endAddr> keyCodes[numKeyCodes];
} [[format_read("format_key_code_list_section")]];

fn format_key_code_list_section(KeyCodeListSection list) {
    return std::format(
        "{} {}",
        list.numKeyCodes,
        list.numKeyCodes == 1 ? "key code" : "key codes"
        );
};

/*******************************************************************************
 * ROM file
 ******************************************************************************/

struct GSROM {
    HeaderSection header @ 0x00000000;

    bool isV3Firmware    = read_u32_at(0x00001000) == 0x00000000;
    bool isV2GameList    = read_u32_at(0x0002DFF0) == 0x00000000;
    bool isV2KeyCodeList = read_u32_at(0x0002D7F0) == 0x00000000;
    bool isV3KeyCodeList = read_u32_at(0x0002FBF0) == 0xFFFFFFFF;
    bool hasUserConfig   = read_u32_at(0x0002FAF0) == 0xFFFFFFFF;

    u32 firmwareAddr    = isV3Firmware ? 0x00001080 : 0x00001000;
    u32 gameListAddr    = isV2GameList ? 0x0002E000 : 0x00030000;
    u32 keyCodeListAddr = isV3KeyCodeList ? 0x0002FC00 : (isV2KeyCodeList ? 0x0002D800 : 0xFFFFFFFF);

    FirmwareSection firmware @ firmwareAddr;
    GameListSection gameList @ gameListAddr;

    if (keyCodeListAddr != 0xFFFFFFFF) {
        KeyCodeListSection keyCodeList @ keyCodeListAddr;
    }

    if (hasUserConfig) {
        UserConfigSection userConfig @ 0x0002FB00;
    }

    str fwBrand = "UNKNOWN";
    match (header.firmwareBrand) {
        (FirmwareBrand::GAMESHARK):       fwBrand = "gs";
        (FirmwareBrand::ACTION_REPLAY):   fwBrand = "ar";
        (FirmwareBrand::PERFECT_TRAINER): fwBrand = "perfect-trainer";
        (FirmwareBrand::LIBRESHARK):      fwBrand = "libreshark";
    }

    str fwVersion = std::format(
        "v{:.2f}{}",
        header.firmwareVersion,
        std::string::to_lower(std::string::substr(header.firmwareDisambiguator, 0, 3))
        );

    str firmwareId = std::format(
        "n64-{}-{}-{}",
        fwBrand,
        fwVersion,
        header.buildTimestamp.id
        );

    std::print("");
    std::print("Firmware ID: {}", firmwareId);
    std::print("");
}; // [[format_read("format_gsrom")]];

fn format_gsrom(GSROM rom) {
    return std::format(
        "{}",
        rom.header.buildTimestamp);
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

u64 fileSize = std::mem::size();
assert(fileSize == 0x00040000, "N64 GameShark ROMs must be EXACTLY 256 KiB (0x40000 bytes), but found 0x{:X} bytes.", fileSize);

be GSROM gsrom @ 0x00;
