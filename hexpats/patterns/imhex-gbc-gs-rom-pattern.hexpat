/*!
 * ImHex pattern for Blaze Xploder GB ROM files (firmware dumps).
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-06-19
 * @license MIT
 */

#pragma MIME application/x-gbc-gs-rom

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
 * ROM file
 ******************************************************************************/

struct Code {
    u8 bytes[4] [[COLOR_LOWLIGHT]];
} [[format_read("format_code")]];

fn format_code(Code code) {
    return std::format(
        "{:02X}{:02X}{:02X}{:02X}",
        code.bytes[0],
        code.bytes[1],
        code.bytes[2],
        code.bytes[3]
        );
};

struct Cheat {
    Code code [[FORMAT_BYTES]];
    char cheatName[0xC] [[COLOR_PRIMARY]];
    u8 unknownByte1 [[COLOR_IMPORTANT]];
    u8 unknownByte2 [[COLOR_IMPORTANT]];
    //char name[] [[COLOR_PRIMARY]];
    //u8 codeCount [[COLOR_LOWLIGHT]];
    //Array<Code, codeCount> codes;
}; // [[format_read("format_cheat")]];

fn format_cheat(Cheat cheat) {
    return std::format(
        "\"{}\" ({} {})",
        cheat.name,
        cheat.codeCount,
        cheat.codeCount == 1 ? "code" : "codes");
};

struct CheatList {
    // The number 455 is hard-coded and pre-allocated in the ROM file.
    // WARNING: Some versions pre-allocate with spaces, other preallocate with null bytes!
    Cheat cheats1[455];
    u8 unknownByte1 [[COLOR_IMPORTANT]];
    u8 unknownByte2 [[COLOR_IMPORTANT]];
    Cheat cheats2[455];
    u8 unknownByte3 [[COLOR_IMPORTANT]];
    u8 unknownByte4 [[COLOR_IMPORTANT]];
    Cheat cheats3[455];
};

struct Game {
    // A value of 0x00 indicates that the game slot is NOT being used.
    u16 gameNumber1Indexed [[COLOR_LOWLIGHT]];
    char gameName[16] [[COLOR_PRIMARY]];
}; // [[format_read("format_game")]];

fn format_game(Game game) {
    return std::format(
        "\"{}\" ({} {})",
        game.name,
        game.cheatCount,
        game.cheatCount == 1 ? "cheat" : "cheats");
};

struct GameList {
    u8 unknownByte1 [[COLOR_IMPORTANT]];
    u8 unknownByte2 [[COLOR_IMPORTANT]];

    // this number is hard-coded and pre-allocated in the ROM file
    Game games[455];
};

struct ROM {
    char productId[]           @ 0x00000134;
    char versionNum[]          @ 0x00000143;

    GameList gameList @ 0x00008000;
    CheatList cheatList @ 0x0000A000;
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

u64 fileSize = std::mem::size();
assert(fileSize == 0x00020000, "GBC GameShark/Action Replay ROMs must be EXACTLY 128 KiB (0x20000 bytes), but found 0x{:X} bytes.", fileSize);

le ROM rom @ 0x00;
