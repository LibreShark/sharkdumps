/*!
 * ImHex pattern for GBC "Shark MX" firmware dumps.
 *
 * @author CheatoBaggins <cheatobaggins@gmail.com>
 * @date 2023-05-04
 * @license MIT
 */

#pragma MIME application/x-gb-shark-mx-rom

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

fn is_padding() {
    u32 val = read_u32_at($);
    return val == 0x00000000 ||
           val == 0xFFFFFFFF;
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

struct TimeZoneEntry {
    char utcOffsetStr[3]  [[COLOR_LOWLIGHT]];
    u8 unknown[2]         [[COLOR_IMPORTANT, FORMAT_BYTES]];
    char name[]           [[COLOR_PRIMARY]];
} [[format_read("format_tz_entry")]];

fn format_tz_entry(TimeZoneEntry tz) {
    return std::format(
        "UTC{} ({})",
        tz.utcOffsetStr,
        tz.name
        );
};

struct Contact {
    char entryNumber[2]  [[COLOR_LOWLIGHT]];
    char personName[]    [[COLOR_PRIMARY]];
    char emailAddress[]  [[COLOR_IMPORTANT]];
    char unknownField1[] [[COLOR_IMPORTANT]];
    char unknownField2[] [[COLOR_IMPORTANT]];
    char phoneNumber[]   [[COLOR_IMPORTANT]];
    char streetAddress[] [[COLOR_IMPORTANT]];
} [[format_read("format_mem_entry")]];

fn format_mem_entry(Contact entry) {
    return std::format(
        "Contact # {}: \"{}\": \"{}\"",
        entry.entryNumber,
        entry.personName,
        entry.emailAddress
        );
};

struct Message {
    char subject[while(is_printable_char())];
    padding[1];
    char senderAddr[while(is_printable_char())];
    padding[1];
    char unknownField1[while(is_printable_char())];
    padding[1];
    char date[while(is_printable_char())];
    padding[1];
    char message[while(is_printable_char())];
    padding[1];
    char unknownField2[while(is_printable_char())];
};

struct Rom {
    u32 welcomeAddr = find($, std::mem::size(), 'W','e','l','c','o','m','e',' ','t','o');
    u32 versionAddr = find($, std::mem::size(), 'S','h','a','r','k',' ','M','X',' ');
    char welcome[] @ welcomeAddr;
    char version[] @ versionAddr;
    Array<TimeZoneEntry, 41> timeZones @ 0x00009257;
    Array<Contact, 50> contacts        @ 0x0000C060;
    char unknownStr1[]    @ 0x00018400;
    char regCodeCopy1[16] @ 0x00020000;
    char regCodeCopy2[16] @ 0x00020010;
    char secretPin[while(is_printable_char())] @ 0x0002007C;
    Message messages[while(!is_padding())] @ 0x00021000;
};

/*******************************************************************************
 * Bootstrap
 ******************************************************************************/

u64 fileSize = std::mem::size();
assert(fileSize == 0x00040000, "GBC Shark MX ROMs must be EXACTLY 256 KiB (0x40000 bytes), but found 0x{:X} bytes.", fileSize);

le Rom rom @ 0x00;
