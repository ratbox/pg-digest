/* pg_digest.c: storage-efficient hash digest data type */
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
#include <postgres.h>
#include <fmgr.h>
#include <utils/builtins.h>
#include <utils/uuid.h>

/*
 * The generic hash digest data type implemented here piggybacks
 * on the existing bytea data type save for its inpit and output
 * functions because bytea's string format is somewhat different.
 */

PG_FUNCTION_INFO_V1(pg_digest_in);
Datum
pg_digest_in(PG_FUNCTION_ARGS)
{
	char *in = PG_GETARG_CSTRING(0);
	Size len = strlen(in);
	bytea *out = (bytea *)palloc(VARHDRSZ + len / 2);

	SET_VARSIZE(out, hex_decode(in, len, out));
	PG_RETURN_BYTEA_P(out);
}

PG_FUNCTION_INFO_V1(pg_digest_out);
Datum
pg_digest_out(PG_FUNCTION_ARGS)
{
	bytea *in = PG_GETARG_BYTEA_P(0);
	char *out = (char *)palloc(VARSIZE(in) * 2 + 1);

	out[hex_encode(VARDATA(in), VARSIZE(in), out)] = 0;
	PG_RETURN_CSTRING(out);
}

#ifdef	PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif	/* PG_MODULE_MAGIC */

/*
 * vim: ts=4 sw=4
 */
