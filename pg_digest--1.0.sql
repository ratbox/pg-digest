/* pg_digest--1.0.sql: pg_digest extension SQL file */
/*
 * Copyright (C) 2018 Aleksey Gerasimov
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
\echo Use "CREATE EXTENSION pg_digest" to load this file.\quit

CREATE FUNCTION digest_in(cstring)
RETURNS digest AS 'MODULE_PATHNAME', 'pg_digest_in'
LANGUAGE c IMMUTABLE STRICT;

CREATE FUNCTION digest_out(digest)
RETURNS cstring AS 'MODULE_PATHNAME', 'pg_digest_out'
LANGUAGE c IMMUTABLE STRICT;

CREATE FUNCTION digest_recv(internal)
RETURNS digest AS 'bytearecv'
LANGUAGE internal STABLE STRICT;

CREATE FUNCTION digest_send(digest)
RETURNS bytea AS 'byteasend'
LANGUAGE internal STABLE STRICT;

CREATE TYPE digest (
	INPUT			= digest_in,
	OUTPUT			= digest_out,
	RECEIVE			= digest_recv,
	SEND			= digest_send,
	INTERNALLENGTH	= variable,
	STORAGE			= extended
);

CREATE CAST (digest AS bytea) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (bytea AS digest) WITHOUT FUNCTION AS IMPLICIT;

/*
 * vim: ts=4 sw=4
 */
