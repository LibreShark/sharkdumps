/*!
 * ImHex pattern for Game Boy GameShark firmware dumps.
 *
 * Original file path:
 * C:\Program Files\Interact\GameShark for GameBoy\gbdata\gbcheats.bin
 *
 * See
 * https://github.com/visualboyadvance-m/visualboyadvance-m/blob/24b92462f90ba44a218daa5a4cc5db1b27446119/src/wx/cmdevents.cpp#L430
 *
 * game_type() == IMAGE_GBA ? _("Game Shark Code File (*.spc;*.xpc)|*.spc;*.xpc") : _("Game Shark Code File (*.gcf)|*.gcf")
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-07-03
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

fn is_eof() {
    u64 fileSize = std::mem::size();
    return $ >= fileSize;
};

fn is_padding() {
    u32 i = read_u32_at($);
    return i == 0x00000000 ||
           i == 0xFFFFFFFF;
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

struct Cheat {
    u16 gameIndex [[COLOR_HIGHLIGHT]];
    char name[12] [[COLOR_PRIMARY]];
    char codeStr[8] [[COLOR_LOWLIGHT]];
};

struct Game {
    u16 gameIndex [[COLOR_LOWLIGHT]];
    char name[16] [[COLOR_PRIMARY]];
};

struct ROM {
    u16 gameCount;
    Game games[gameCount];

    u16 cheatCount;
    Cheat cheats[while(!is_eof())];
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

le ROM rom @ 0x00;
