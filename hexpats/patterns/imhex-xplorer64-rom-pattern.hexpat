/*!
 * ImHex pattern for N64 Xplorer 64 ROM files (firmware dumps).
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-04-26
 * @license MIT
 */

#pragma MIME application/x-n64-xplorer64-rom

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

fn is_float_char() {
    u8 b = read_next_byte();
    return std::ctype::isdigit(b) || b == '.';
};

fn is_version_char() {
    u8 b = read_next_byte();
    return std::ctype::isalnum(b) || b == '.';
};

fn is_iso_date_char() {
    u8 b = read_next_byte();
    return (b >= '0' && b <= '9') || b == '-';
};

fn is_years_char() {
    u8 b = read_next_byte();
    return std::ctype::isdigit(b) || b == '/';
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

enum Lang : u8 {
    ENGLISH = 'E',
    GERMAN = 'G',
};

struct HeaderSection {
    char c[4];
    char years[while(is_years_char())];
    u32 versionAddr = find($, $ + 0x60, 'R','e','l','e','a','s','e',' ');
    $ = versionAddr + 8;
    char versionStr[while(is_version_char())];
    Lang lang @ $ - 1;
    padding[while(is_null())];
    char buildStr[while(is_version_char())];
    char manufacturer[] @ 0x40;
    char disclaimer[] @ 0x200;
    char greetz[] @ 0x800;
    char toolchain[] @ 0x8A0;
    char team[] @ 0x900;
    char website[] @ 0x940;

    double versionNumber = parse_float(versionStr);
    double buildNumber = parse_int(buildStr);
};

/*******************************************************************************
 * Xplorer 64 unencrypted ROM
 ******************************************************************************/

struct FirmwareSection {
    u32 wayneAddr = find(0, 0x20000, 'W','a','y','n','e',' ',
                                     'H','u','g','h','e','s',' ',
                                     'B','e','c','k','e','t','t','!');
    char wayne[] @ wayneAddr;
    char buildTimestamp[] @ wayneAddr + 0x40;
};

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

/*

Perfect Dark

# GameShark codes (North American game version):
https://www.valice.net/gameshark/01_main.html

All Weapons:

D013EE6F 001E
8013EE70 0007

D0140ADF 001E
80140AE0 0007

50001801 0000
800ACCC9 0001

---

# Xplorer 64 codes (European game version):
https://www.angelfire.com/emo/kudrun/statistics.html
https://www.nesworld.com/n64/files/xploder64/pd.txt

ED5DF208 596A
E86FCA2F 594F

ED5DF208 596A
E8768A48 5957

*/

// TODO(CheatoBaggins): Decrypt codes
struct Code {
    u32 startAddr = $;

    OpCode opcode;
    u8 address[3] [[format_read("format_code_address")]];
    u8 value[2]   [[format_read("format_code_value")]];

    u8 enc[6] @ startAddr [[FORMAT_BYTES]];
    std::print("");
    std::print("ENCRYPTED code: {:02X}{:02X}{:02X}{:02X} {:02X}{:02X}", enc[0], enc[1], enc[2], enc[3], enc[4], enc[5]);
    std::print("");
} [[COLOR_IMPORTANT, format_read("format_code")]];

fn format_code(Code code) {
    return std::format(
        "{:02X}{} {}",
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

struct Cheat {
    char name[];
    u8 codeCount [[COLOR_LOWLIGHT]];
    Code codes[codeCount];
} [[format_read("format_cheat")]];

fn format_cheat(Cheat cheat) {
    return std::format(
        "{} ({} {})",
        cheat.name,
        cheat.codeCount,
        cheat.codeCount == 1 ? "code" : "codes"
        );
};

struct Game {
    char name[];
    u8 cheatCount [[COLOR_LOWLIGHT]];
    Cheat cheats[cheatCount];
};

fn is_padding(u32 val) {
    return val == 0x00000000 || val == 0xFFFFFFFF;
};

fn is_section_padding() {
    u32 chunk1 = read_u32_at($);
    u32 chunk2 = read_u32_at($ + 4);
    return is_padding(chunk1) &&
           is_padding(chunk2);
};

struct GameListSection {
    // TODO(CheatoBaggins): Find cheat count
    Game games[while(!is_section_padding())] [[COLOR_PRIMARY]];
};

struct Xp64RomFile {
    HeaderSection header     @ 0x00000000;
    FirmwareSection firmware @ 0x00003C80;
    GameListSection gameList @ 0x00030000;
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

u64 fileSize = std::mem::size();
assert(fileSize == 0x00040000, "Xplorer 64 ROMs must be EXACTLY 256 KiB (0x40000 bytes), but found 0x{:X} bytes.", fileSize);

be Xp64RomFile romFile @ 0x00;
