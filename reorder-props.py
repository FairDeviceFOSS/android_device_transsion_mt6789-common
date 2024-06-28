#!/usr/bin/env python
#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

from locale import LC_ALL, setlocale, strcoll
from pathlib import Path

FILES = [Path(file) for file in [
    "configs/properties/system.prop",
    "configs/properties/vendor.prop"
]]

setlocale(LC_ALL, "C")

def strcoll_extract_utils(string1: str, string2: str) -> int:
    # Skip logic if one of the string if empty
    if not string1 or not string2:
        return strcoll(string1, string2)

    # If no sub property, compare normally
    if not "." in string1 and not "." in string2:
        return strcoll(string1, string2)

    string1_prop = string1.rsplit(".", 1)[0] + "."
    string2_prop = string2.rsplit(".", 1)[0] + "."
    if string1_prop == string2_prop:
        # Same property, compare normally
        return strcoll(string1, string2)

    if string1_prop.startswith(string2_prop):
        # First string prop is a property of the second one,
        # return string1 > string2
        return -1

    if string2_prop.startswith(string1_prop):
        # Second string prop is a property of the first one,
        # return string2 > string1
        return 1

    # Compare normally
    return strcoll(string1, string2)

for file in FILES:
    if not file.is_file():
        print(f"File {str(file)} not found")
        continue

    with open(file, 'r') as f:
        sections = f.read().split("\n\n")

    ordered_sections = []
    for section in sections:
        section_list = [line.strip() for line in section.splitlines()]
        section_list.sort(key=lambda line: line.split('=')[0])
        ordered_sections.append("\n".join(section_list))

    with open(file, 'w') as f:
        f.write("\n\n".join(ordered_sections).strip() + "\n")
