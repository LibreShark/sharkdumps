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
    u8 code[4] [[FORMAT_BYTES, COLOR_HIGHLIGHT]];
    padding[1];
    u8 cheatNameIndex [[COLOR_IMPORTANT]];
}; // [[format_read("format_cheat")]];

fn format_cheat(Cheat cheat) {
    return std::format(
        "\"{}\" ({} {})",
        cheat.name,
        cheat.codeCount,
        cheat.codeCount == 1 ? "code" : "codes");
};

/*
Inf Energy 010591DD
Four Lives 010494DD
Five Lives 010594DD
Six Lives  010594DD
*/
struct Game {
    char gameName[16] [[COLOR_PRIMARY]];
    u8 cheatCount [[COLOR_LOWLIGHT]];
    Cheat cheats[cheatCount];
} [[format_read("format_game")]];

fn format_game(Game game) {
    return game.gameName;
    // return std::format(
    //     "\"{}\" ({} {})",
    //     game.name,
    //     game.cheatCount,
    //     game.cheatCount == 1 ? "cheat" : "cheats");
};

struct CheatNameDef {
    char name[16];
} [[format_read("format_cheat_name_def")]];

fn format_cheat_name_def(CheatNameDef def) {
    return def.name;
};

struct ROM {
    u32 arAddr1 = find(0, std::mem::size(), 'A','C','T','I','O','N',' ','R','E','P','L','A','Y');
    u32 gsAddr1 = find(0, std::mem::size(), 'G','a','m','e','S','h','a','r','k');
    u32 arAddr2 = find(0, std::mem::size(), 'A','c','t','i','o','n',' ','R','e','p','l','a','y');
    u32 thanksAddr = find(0, std::mem::size(), 'T','h','a','n','k','s',' ','f','o','r',' ');
    u32 datelAddr = find(0, std::mem::size(), 'D','a','t','e','l',' ','D','e','s','i','g','n');
    u32 verAddr = find(0, std::mem::size(), 'V','e','r','.',' ');
    u32 proAddr = find(datelAddr, datelAddr + 0xFF, 'P','R','O');
    u32 arAddr3 = find(datelAddr, datelAddr + 0xFF, 'A','C','T','I','O','N',' ','R','E','P','L','A','Y');
    u32 damonAddr = find(0, std::mem::size(), 'D','a','m','o','n',' ','B','a','r','w','i','n');

    assert(arAddr1 > 0 && arAddr1 < 0xFFFFFFFF, "Failed to find string \"ACTION REPLAY\" in ROM file!");
    assert(gsAddr1 > 0 && gsAddr1 < 0xFFFFFFFF, "Failed to find string \"GameShark\" in ROM file!");
    assert(arAddr2 > 0 && arAddr2 < 0xFFFFFFFF, "Failed to find string \"Action Replay\" in ROM file!");
    assert(datelAddr > 0 && datelAddr < 0xFFFFFFFF, "Failed to find string \"Datel Design\" in ROM file!");
    assert(verAddr > 0 && verAddr < 0xFFFFFFFF, "Failed to find string \"Ver. \" in ROM file!");

    char arCaps1[] @ arAddr1;
    char gsTitle[] @ gsAddr1;
    char arTitle[] @ arAddr2;
    char thanksStr[] @ thanksAddr;
    char datelDesign[] @ datelAddr;
    char version[] @ verAddr;

    if (proAddr < 0xFFFFFFFF) {
        char pro[] @ proAddr;
    }
    if (arAddr3 < 0xFFFFFFFF) {
        char arCaps2[] @ arAddr3;
    }
    if (damonAddr < 0xFFFFFFFF) {
        char damonBarwin1[] @ damonAddr;
    }

    u32 copySearchStart = datelAddr + sizeof(datelDesign);
    u32 copySearchEnd = copySearchStart + 0xFF;
    u32 copyAddr = find(copySearchStart, copySearchEnd, 'C','o','p','y');
    $ = copyAddr;
    padding[while(!is_digit())];
    char year[];

    $ = 0xA000;
    CheatNameDef cheatNames[while(!is_padding())];

    $ = 0x10000;
    Game games[while(!is_padding())];
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

u64 fileSize = std::mem::size();
assert(fileSize == 0x00020000, "GBC GameShark/Action Replay ROMs must be EXACTLY 128 KiB (0x20000 bytes), but found 0x{:X} bytes.", fileSize);

le ROM rom @ 0x00;

// u8 cheatCount @ 0x1010E;
// u8 u8_array_at_0x10115[0x04] @ 0x10115;
// u8 u8_array_at_0x1010F[0x04] @ 0x1010F;
// u8 u8_array_at_0x1011B[0x04] @ 0x1011B;
// u8 u8_array_at_0x10121[0x04] @ 0x10121;
// char char_array_at_0x100FE[0x10] @ 0x100FE;
