////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#ifndef REALM_OS_UTIL_TIME_HPP
#define REALM_OS_UTIL_TIME_HPP

#include <cstring>
#include <ctime>
#include <string>
#include <system_error>

namespace realm {
namespace util {

// Like std::localtime, but safe with reentrancy and multiple threads.
inline std::tm localtime(std::time_t time)
{
    std::tm calendar_time;
#if defined(WIN32)
    auto* result = localtime_s(&time, &calendar_time);
#else
    auto* result = localtime_r(&time, &calendar_time);
#endif
    if (!result)
        throw std::system_error(errno, std::system_category());

    return calendar_time;
}

// Like std::put_time, but compatible with GCC 4.9.
inline std::string put_time(std::time_t time, const char *format)
{
    std::tm calendar_time = localtime(time);
    size_t estimated_length = std::strlen(format) + 1;

    size_t formatted_length;
    std::string buffer;

    // Loop until the buffer is large enough to hold the string generated by `strftime`, growing the
    // buffer by 8 characters whenever it is too small to hold the resulting string.
    do {
        buffer.resize(estimated_length);
        formatted_length = strftime(&buffer[0], buffer.size(), format, &calendar_time);
        estimated_length += 8;
    } while (formatted_length == 0);

    buffer.resize(formatted_length);
    return buffer;
}

} // namespace util
} // namespace realm

#endif // REALM_OS_UTIL_TIME_HPP