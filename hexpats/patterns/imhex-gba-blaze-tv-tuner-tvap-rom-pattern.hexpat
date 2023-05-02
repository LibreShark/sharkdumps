/*!
 * ImHex pattern for Blaze TV Tuner firmware dumps for Game Boy Advance.
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-05-04
 * @license MIT
 */

#pragma MIME application/x-gba-blaze-tvap-rom

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

fn read_byte_at(u32 pos) {
    return std::mem::read_unsigned(pos, 1);
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

fn is_space() {
    u8 b = read_next_byte();
    return b == ' ';
};

fn is_whitespace() {
    u8 b = read_next_byte();
    return b == ' ' || b == '\t' || b == '\n' || b == '\r' || b == '\f';
};

fn is_tabdb() {
    u8 b1 = read_byte_at($ + 0);
    u8 b2 = read_byte_at($ + 1);
    u8 b3 = read_byte_at($ + 2);
    bool isTab = b1 == 0x09;
    bool isD = b2 == 'd';
    bool isB = b3 == 'b';
    std::print("");
    std::print("0x{:08X} = '{}' (0x{:02X}) == '\t': {}", $ + 0, char(b1), b1, isTab);
    std::print("0x{:08X} = '{}' (0x{:02X}) == 'd': {}", $ + 1, char(b2), b2, isD);
    std::print("0x{:08X} = '{}' (0x{:02X}) == 'b': {}", $ + 2, char(b3), b3, isB);
    bool ret = isTab && isD && isB;
    std::print("> is_tabdb() = {}", ret);
    std::print("");
    return ret;
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

struct PaddedString {
    padding[while(is_null())];
    char content[];
    padding[while(is_null())];
} [[format_read("format_padded_string")]];

fn format_padded_string(PaddedString s) {
    return s.content;
};

struct CountryString {
    u32 startAddr = $;
    char name[];
    padding[while($ < startAddr + 0x20)];
} [[format_read("format_country_string")]];

fn format_country_string(CountryString s) {
    return s.name;
};

struct ROM {
    char romName[] @ 0xA0;
    char romId[] @ 0xAC;

    /*
SECAM-2(-6.5Mhz)
PAL-B/G(5.5Mhz)
PAL-I(6.0Mhz)
PAL-D/K(6.5Mhz)
SECAM-1(6.5M)
    */
    Array<PaddedString,  7> formatStrings1 @ 0x00002858;
    Array<PaddedString, 16> formatStrings2 @ 0x0000316C;
    Array<PaddedString,  2> formatStrings3 @ 0x00004DC8;

    Array<PaddedString,  7> formatStrings4 @ 0x00102858;
    Array<PaddedString, 16> formatStrings5 @ 0x0010316C;
    Array<PaddedString,  2> formatStrings6 @ 0x001032D8;

    Array<PaddedString,  7> formatStrings7 @ 0x00482858;
    Array<PaddedString, 16> formatStrings8 @ 0x0048316C;
    Array<PaddedString,  2> formatStrings9 @ 0x004832D8;

    char tvPal1[]  @ 0x00104DC8;
    char tvNtsc1[] @ 0x00104DD4;

    char tvPal2[]  @ 0x00404DC8;
    char tvNtsc2[] @ 0x00404DD4;

    char tvPal3[]  @ 0x00484DC8;
    char tvNtsc3[] @ 0x00484DD4;

    u8 hexByteArt1[0xD20] @ 0x0010D380;
    u8 hexByteArt2[0xD20] @ 0x0020D380;
    u8 hexByteArt3[0xD20] @ 0x0038D380;
    u8 hexByteArt4[0xD20] @ 0x0040D380;

    Array<CountryString, 5> countries @ 0x0048A5BC;
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

u64 fileSize = std::mem::size();
// assert(fileSize == 0x01000000, "GBA Blaze TV Tuner ROMs must be EXACTLY 16 MiB (0x01000000 bytes), but found 0x{:X} bytes.", fileSize);

be ROM rom @ 0x00;
