# About pg-digest

`pg-digest` is a PostgreSQL extension for a storage-efficient digest data type.

It implements `digest`, a `varlena`-based data type for efficient storing of
binary blobs meant for hash function digests, encryption keys, and checksums.
It is binary compatible with the `bytea` data type and has an overhead of either
1 or 4 bytes depending on whether the underlying `varlena` is stored packed or
unpacked.

# Installation

The extension is built using the standard PostgreSQL PGXS facility:
```
# cd pg-digest
# make
# make install
```
These steps will build the shared object and install it appropriately.

# Usage

In order to use `pg-digest`, issue the following statement:
```
CREATE EXTENSION pg_digest;
```
Then the `digest` data type may be used anywhere just like any other type, e.g.:
```
CREATE TABLE file_upload (
	path	text   NOT NULL PRIMARY KEY,
	hash	digest NOT NULL UNIQUE
);
```

# Copying

Copyright (C) 2018 Aleksey Gerasimov

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
