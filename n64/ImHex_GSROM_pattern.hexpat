/*!
 * ImHex pattern for N64 GameShark ROM files (firmware dumps).
 * Supports all known GameShark firmware versions
 * (tested on v1.02 through v3.30).
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-04-26
 */

#include <type/magic.pat>
#include <type/size.pat>
#include <type/time.pat>

#include <std/array.pat>
#include <std/ctype.pat>
#include <std/hash.pat>
#include <std/math.pat>
#include <std/mem.pat>
#include <std/string.pat>
#include <std/sys.pat>
#include <std/time.pat>

/*******************************************************************************
 * Header section
 ******************************************************************************/

str GS_ROM_FILE_MAGIC = "\x80\x37\x12\x40";

enum BgPattern : u8 {
    SILK  = 0x00,
    ROCK  = 0x01,
    SHARK = 0x02,
};

enum BgColor : u8 {
    GREY   = 0x00,
    TAN    = 0x01,
    BLUE   = 0x02,
    GREEN  = 0x03,
    PINK   = 0x04,
    YELLOW = 0x05,
    RED    = 0x06,
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
    char HH[2];
    char colon[1];
    char mm[2];
    char space1[1];
    char MMM[3];
    char space2[1];
    char dd[while(std::ctype::isdigit(std::mem::read_unsigned($, 1)))];
    char space3[1];
    char yy[while(std::ctype::isdigit(std::mem::read_unsigned($, 1)))];

    bool hasYear = std::string::length(yy) > 0;

    u16 year = hasYear ? std::string::parse_int("19" + yy, 10) : 2000;
    u8 month = parse_month(MMM);
    u8 day = std::string::parse_int(dd, 10);
    u8 hour = std::string::parse_int(HH, 10);
    u8 minute = std::string::parse_int(mm, 10);
} [[format_read("format_header_build_timestamp"), color("00FF00")]];

fn format_header_build_timestamp(BuildTimestamp bts) {
    return std::format(
        "{:04d}-{:02d}-{:02d}T{:02d}:{:02d}",
        bts.year,
        bts.month,
        bts.day,
        bts.hour,
        bts.minute);
};

struct HeaderSection {
    char magic[4] [[format_read("format_header_magic")]];

    std::assert(magic == GS_ROM_FILE_MAGIC, std::format("Invalid magic value! Expected \"{}\", got \"{}\".", GS_ROM_FILE_MAGIC, magic));

    std::mem::Bytes<4> unknown1 [[color("000000"), hidden]];

    u8 maybeKeyCodeChecksum[3]  [[color("FF0000"), format_read("format_header_key_code_checksum")]];

    std::mem::Bytes<1> unknown2 [[color("000000"), hidden]];
    std::mem::Bytes<4> unknown3 [[color("000000"), hidden]];

    u8 activeKeyCodePrefix[8]   [[color("FF0000"), format_read("format_header_active_key_code_prefix")]];

    std::mem::Bytes<8> unknown4 [[color("000000"), hidden]];

    char manufacturerName[16]   [[color("FFFF00")]];
    BuildTimestamp buildTimestamp;

    bool isV1or2 = manufacturerName == "(C) DATEL D&D NU";
    bool isV3Pro = manufacturerName == "(C) MUSHROOM &NU";
    bool isTrain = manufacturerName == "Perfect Trainer ";
    std::assert(isV1or2 || isV3Pro || isTrain, std::format("Invalid manufacturer name! Got \"{}\".", manufacturerName));
} [[format_read("format_header_section")]];

fn format_header_magic(str magic) {
    return std::format(
        "{:02X} {:02X} {:02X} {:02X}",
        u8(magic[0]),
        u8(magic[1]),
        u8(magic[2]),
        u8(magic[3]));
};

fn format_header_section(HeaderSection hdr) {
    return std::format(
        "Built on \"{}\". Active key code: \"{}  {}\".",
        hdr.buildTimestamp,
        hdr.activeKeyCodePrefix,
        hdr.maybeKeyCodeChecksum);
};

fn format_header_key_code_checksum(auto maybeKeyCodeChecksum) {
    return std::format(
        "{:02X} {:02X} {:02X}",
        maybeKeyCodeChecksum[0],
        maybeKeyCodeChecksum[1],
        maybeKeyCodeChecksum[2]);
};

fn format_header_active_key_code_prefix(auto activeKeyCodePrefix) {
    return std::format(
        "{:02X} {:02X} {:02X} {:02X} {:02X} {:02X} {:02X} {:02X}",
        activeKeyCodePrefix[0],
        activeKeyCodePrefix[1],
        activeKeyCodePrefix[2],
        activeKeyCodePrefix[3],
        activeKeyCodePrefix[4],
        activeKeyCodePrefix[5],
        activeKeyCodePrefix[6],
        activeKeyCodePrefix[7]);
};

/*******************************************************************************
 * Firmware section
 ******************************************************************************/

struct FirmwareSection {
    u32 startAddr = $;
    u32 approxEndAddr = startAddr + 0x0002D000;

    u32 titleAddr = std::mem::find_sequence_in_range(
        /* occurrence_index = */ 0,
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ approxEndAddr,
        /* bytes            = */ 'N','6','4',' ',
                                 'G','a','m','e','S','h','a','r','k',' ',
                                 'V','e','r','s','i','o','n',' '
        );

    if (titleAddr != 0xFFFFFFFF) {
        char mainMenuTitle[]   @ titleAddr      [[color("00FF00")]];
        char mainMenuVersion[] @ titleAddr + 22 [[color("0000FF")]];

        double versionNumber = std::string::parse_float(mainMenuVersion);
        std::print(std::format("Firmware version: v{}", versionNumber));
    } else {
        std::print(std::format("Firmware version: UNKNOWN (firmware is compressed; unable to read)"));
    }
}; // [[format_read("format_firmware_section")]];

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
        u8 unknown1 [[color("000000")]];
        bool isBackgroundScrollOn;
        u8 unknown2[2] [[color("000000")]];
        u8 unknown3 [[color("000000")]];
        padding[0x61];
        bool isMenuScrollOn;
    } else if (isPristine) {
        // Brand new cart with factory settings.
        std::mem::Bytes<0x6D> uninitialized;
    } else {
        // v2.21 and earlier do not have a user config section.
        std::mem::Bytes<0x00> notPresent;
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
} [[format_read("format_code"), color("FF0000")]];

fn format_code(Code code) {
    return std::format(
        "{:02X}{:02X}{:02X}{:02X} {:02X}{:02X}",
        u8(code.opcode),
        code.address[0],
        code.address[1],
        code.address[2],
        code.value[0],
        code.value[1]);
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
    bool isCheatEnabled : 1 [[color("FF1493")]];
    unsigned numCodes : 7   [[color("0000FF")]];
} [[format_read("format_cheat_code_count")]];

fn format_cheat_code_count(CodeCount ccc) {
    return std::format(
        "{} {}, {}",
        ccc.numCodes,
        ccc.numCodes == 1 ? "code" : "codes",
        ccc.isCheatEnabled ? "ENABLED by default" : "DISABLED by default");
};

struct Cheat {
    char name[]         [[color("00FF00")]];
    CodeCount codeCount [[color("0000FF")]];
    std::Array<Code, codeCount.numCodes> codes;
} [[format_read("format_cheat")]];

fn format_cheat(Cheat cheat) {
    return std::format(
        "\"{}\" ({})",
        cheat.name,
        cheat.codeCount);
};

struct Game {
    char name[]   [[color("00FF00")]];
    u8 cheatCount [[color("0000FF")]];
    std::Array<Cheat, cheatCount> cheats;
}; // [[format_read("format_game")]];

fn format_game(Game game) {
    return std::format(
        "\"{}\" ({} {})",
        game.name,
        game.cheatCount,
        game.cheatCount == 1 ? "cheat" : "cheats");
};

struct GameListSection {
    padding[2];
    u16 gameCount [[color("0000FF")]];
    std::Array<Game, gameCount> games;
}; // [[format_read("format_game_list")]];

fn format_game_list(GameListSection gameList) {
    return std::format("{} games", gameList.gameCount);
};

/*******************************************************************************
 * Key Code List section
 ******************************************************************************/

struct KeyCode<auto Len, auto MaxAddr> {
    u8 keyCode[Len] [[color("FF0000")]];
    char name[]     [[color("00FF00")]];

    u32 maxAddr = std::math::min($ + 9, MaxAddr);
    padding[while($ < maxAddr && std::mem::read_unsigned($, 1) == 0)];
};

struct KeyCodeListSection {
    u32 startAddr = $;
    u32 endAddr = startAddr + 0xA0;

    u32 marioAddr = std::mem::find_sequence_in_range(
        /* occurrence_index = */ 0,
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ endAddr,
        /* bytes            = */ 'M','a','r','i','o',' ',
                                 'W','o','r','l','d',' ',
                                 '6','4',' ','&',' ',
                                 'O','t','h','e','r','s'
        );
    u32 diddyAddr = std::mem::find_sequence_in_range(
        /* occurrence_index = */ 0,
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ endAddr,
        /* bytes            = */ 'D','i','d','d','y'
        );
    u32 yoshiAddr = std::mem::find_sequence_in_range(
        /* occurrence_index = */ 0,
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ endAddr,
        /* bytes            = */ 'Y','o','s','h','i'
        );
    u32 zeldaAddr = std::mem::find_sequence_in_range(
        /* occurrence_index = */ 0,
        /* offsetFrom       = */ startAddr,
        /* offsetTo         = */ endAddr,
        /* bytes            = */ 'Z','e','l','d','a'
        );

    u8 keyCodeLen = marioAddr - startAddr;
    u8 numKeyCodes = 0;

    if (marioAddr != 0xFFFFFFFF) { numKeyCodes += 1; }
    if (diddyAddr != 0xFFFFFFFF) { numKeyCodes += 1; }
    if (yoshiAddr != 0xFFFFFFFF) { numKeyCodes += 1; }
    if (zeldaAddr != 0xFFFFFFFF) { numKeyCodes += 1; }

    KeyCode<keyCodeLen, endAddr> keyCodes[numKeyCodes];
};

/*******************************************************************************
 * ROM file
 ******************************************************************************/

struct GSROM {
    HeaderSection header @ 0x00000000;

    bool isV3Firmware = std::mem::read_unsigned(0x00001000, 4) == 0;
    bool isV2GameList = std::mem::read_unsigned(0x0002DFF0, 4) == 0;
    bool hasUserConfig = std::mem::read_unsigned(0x0002FAF0, 4) == 0xFFFFFFFF;
    bool isV3KeyCodeList = std::mem::read_unsigned(0x0002FBF0, 4) == 0xFFFFFFFF;
    bool isV2KeyCodeList = std::mem::read_unsigned(0x0002D7F0, 4) == 0x00000000;

    u32 firmwareAddr = isV3Firmware ? 0x00001080 : 0x00001000;
    u32 gameListAddr = isV2GameList ? 0x0002E000 : 0x00030000;
    u32 keyCodeListAddr = isV3KeyCodeList ? 0x0002FC00 : (isV2KeyCodeList ? 0x0002D800 : 0xFFFFFFFF);

    FirmwareSection firmware @ firmwareAddr;
    GameListSection gameList @ gameListAddr;

    if (keyCodeListAddr != 0xFFFFFFFF) {
        KeyCodeListSection keyCodeList @keyCodeListAddr;
    }

    if (hasUserConfig) {
        UserConfigSection userConfig @ 0x0002FB00;
    }
}; // [[format_read("format_gsrom")]];

fn format_gsrom(GSROM rom) {
    return std::format(
        "{}",
        rom.header.buildTimestamp);
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

std::assert(std::mem::size() == 0x00040000, "N64 GameShark ROMs must be EXACTLY 256 KiB.");

be GSROM gsrom @ 0x00;
