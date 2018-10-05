/*
Database user managment
Already created groups, admins and users

- Groups
- User
- Admin

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/utilities/reeem_setup_user_managment.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- Groups
CREATE USER reeem_read WITH LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION;
CREATE USER reeem_user WITH LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION; GRANT reeem_read TO reeem_user;
CREATE USER reeem_admin WITH LOGIN SUPERUSER NOCREATEDB CREATEROLE REPLICATION;


-- User
CREATE ROLE ludwig_huelk LOGIN PASSWORD '' SUPERUSER INHERIT NOCREATEDB CREATEROLE REPLICATION;             GRANT reeem_user TO ludwig_huelk;       -- OB
CREATE ROLE berit_mueller LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;      GRANT reeem_user TO berit_mueller;      -- LH (2017-02-06)
CREATE ROLE pinar_korkmaz  LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;     GRANT reeem_user TO pinar_korkmaz ;     -- LH (2017-02-06)
CREATE ROLE bo_laerke LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;          GRANT reeem_user TO bo_laerke;          -- LH (2017-02-06)
CREATE ROLE serena_fabbri LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;      GRANT reeem_user TO serena_fabbri;      -- LH (2017-02-06)
CREATE ROLE olexandr_balyk LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;     GRANT reeem_user TO olexandr_balyk;     -- LH (2017-02-08)
CREATE ROLE francesco_gardumi LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;  GRANT reeem_user TO francesco_gardumi;  -- LH (2017-02-08)
CREATE ROLE marita_holm LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;        GRANT reeem_user TO marita_holm;        -- LH (2017-02-22)
CREATE ROLE dorothea_schmid LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;    GRANT reeem_user TO dorothea_schmid;    -- LH (2017-07-24)
CREATE ROLE claudia_zabel LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;      GRANT reeem_user TO claudia_zabel;      -- LH (2017-07-24)
CREATE ROLE roland_montenegro LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;  GRANT reeem_user TO roland_montenegro;  -- LH (2017-07-24)
CREATE ROLE hauke_henke LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;        GRANT reeem_user TO hauke_henke;        -- LH (2017-07-24)
CREATE ROLE eimantas_neniskis LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;  GRANT reeem_user TO eimantas_neniskis;  -- LH (2017-10-18)
CREATE ROLE julia_welsch LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;       GRANT reeem_user TO julia_welsch;       -- LH (2017-10-18)
CREATE ROLE aira_hast LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;          GRANT reeem_user TO aira_hast;          -- LH (2017-10-19)
CREATE ROLE ivana_milinkovic LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;   GRANT reeem_user TO ivana_milinkovic;   -- LH (2017-10-19)
CREATE ROLE martina_mikulic LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;    GRANT reeem_user TO martina_mikulic;    -- LH (2017-10-19)
CREATE ROLE olavur_ellefsen LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;    GRANT reeem_user TO olavur_ellefsen;    -- LH (2017-10-19)
CREATE ROLE andrea_marin LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;       GRANT reeem_user TO andrea_marin;       -- LH (2017-10-19)
CREATE ROLE peihao_li LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;          GRANT reeem_user TO peihao_li;          -- LH (2018-05-22)
CREATE ROLE till_sebastian LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;     GRANT reeem_user TO till_sebastian;     -- LH (2018-09-19)


CREATE ROLE reeem_game LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;         GRANT reeem_read TO reeem_game;         -- LH (2017-02-22)
CREATE ROLE reeem_browser LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;      GRANT reeem_user TO reeem_browser;      -- LH (2018-08-08)

CREATE ROLE test_user LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;          GRANT reeem_user TO test_user;          -- LH (2017-02-22)
CREATE ROLE test_read LOGIN PASSWORD '' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;          GRANT reeem_read TO test_read;          -- LH (2017-02-22)


-- Admin
GRANT reeem_admin TO ludwig_huelk;  -- OB
GRANT reeem_admin TO bo_laerke;     -- LH (2017-10-24)
