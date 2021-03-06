/*
Test table

This script provides an SQL example and the metadata documentation.
A definition of metadata can be found in the openmod glossary http://wiki.openmod-initiative.org/wiki/Metadata

- test table
- access rights
- metadata description
- metadata validation
- insert test data
- select test data

Additional information:
- Dates must follow the ISO8601 (JJJJ-MM-TT)
- Use a space between Numbers and units (100 m)
- If not applicable use "none"

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__contains__    = "http://stackoverflow.com/questions/383692/what-is-json-and-why-would-i-use-it","https://specs.frictionlessdata.io/data-package/"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/blob/master/database_setup/utilities/reeem_example_table.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- test table
DROP TABLE IF EXISTS    model_draft.test_table;
CREATE TABLE            model_draft.test_table (
    "id"            serial NOT NULL,
    "pathway"       text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT table_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.test_table OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.test_table TO reeem_read WITH GRANT OPTION;

-- metadata description
COMMENT ON TABLE model_draft.test_table IS 
    '{"title": "Good example title",
    "description": "Example metadata for example data",
    "language": [ "eng", "ger", "fre" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "2016-01-01",
        "start": "2017-01-01",
        "end": "2017-12-31",
        "resolution": "1 hour"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license": 
        {"id": "ODbL-1.0",
        "name": "Open Data Commons Open Database License 1.0",
        "version": "1.0",
        "url": "https://opendatacommons.org/licenses/odbl/1.0/",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute, Share-Alike, Keep open!",
        "copyright": "© Reiner Lemoine Institut"},
    "contributors": [
        {"name": "Ludee", "email": "", "date": "2016-06-16", "comment": "Create metadata"},
        {"name": "Ludee", "email": "", "date": "2016-11-22", "comment": "Update metadata"},
        {"name": "Ludee", "email": "", "date": "2016-11-22", "comment": "Update header and license"},
        {"name": "Ludee", "email": "", "date": "2017-03-16", "comment": "Add license to source"},
        {"name": "Ludee", "email": "", "date": "2017-03-28", "comment": "Add copyright to source and license"},
        {"name": "Ludee", "email": "", "date": "2017-05-30", "comment": "Update metadata to version 1.3"},
        {"name": "Ludee", "email": "", "date": "2017-06-26", "comment": "Update metadata version 1.3: move reference_date into temporal and remove some array"},
        {"name": "Ludee", "email": "", "date": "2017-12-12", "comment": "Add data classifiaction test array"}],
    "resources": [
        {"name": "model_draft.test_table",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- metadata validation
SELECT obj_description('model_draft.test_table' ::regclass) ::json;


-- insert test data
INSERT INTO model_draft.test_table (schema, category, tags, year, indicator, value)
    SELECT
        'energy_supply',
        'installed_capacity',
        '"energy_type" => "Electric", "technology" => "CHP", "energy_carrier" => "Naturalgas"' ::hstore,
        2015,
        'Installed capacity CHP',
        500 UNION ALL
    SELECT
        'energy_supply',
        'installed_capacity',
        '"energy_type" => "Electric;Thermal", "technology" => "CHP", "energy_carrier" => "Naturalgas"'  ::hstore,
        2020,
        'Installed capacity CHP',
        700;

-- select test data
SELECT  *
FROM    model_draft.test_table
WHERE   tags ? 'energy_type' AND tags -> 'energy_type' LIKE '%Thermal%';

SELECT  *
FROM    model_draft.test_table
WHERE   tags ? 'energy_type' AND tags -> 'energy_type' LIKE '%Electric%';
