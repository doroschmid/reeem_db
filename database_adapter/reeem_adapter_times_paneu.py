"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/4"
__version__ = "v0.1.3"

from reeem_io import *

# input
filename = "2017-11-15_Base(withRen.Target)_TIMESPanEU_FrameworkV1_DataV1_Output.xlsx"
#filename = "2017-10-27_Pilot_TIMESPanEU_Output.xlsx" NOT WORKING!!!
#filename = "2017-11-15_Base_TIMESPanEU_FrameworkV1_DataV1_Input.xlsx"

#regions = ['AT']
#regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES',
#    'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV',
#    'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']
regions = ['AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES',
    'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV',
    'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']

empty_rows = 4

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_times_paneu_input'
db_table_output = 'reeem_times_paneu_output'

def times_paneu_2_reeem_db(filename, fns, empty_rows, db_schema, region, con):
    """read excel file and sheets, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'TIMESPanEU', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))

    # make dataframe
    df.columns = ['indicator', 'unit',
                  '2015', '2020', '2025', '2030', '2035', '2040',
                  '2045', '2050', 'category', 'field', 'aggregation', 'source']
    df.index.names = ['nid']
    #  print(df.dtypes)
    # print(df.head())

    # seperate columns
    dfunit = df[['category', 'field', 'indicator', 'unit', 'aggregation',
                 'source']].copy().dropna()
    dfunit.index.names = ['nid']
    dfunit.columns = ['category', 'field', 'indicator', 'unit', 'aggregation',
                      'source']
    # print(dfunit)
    # print(dfunit.dtypes)

    # drop seperated columns
    dfclean = df.drop(
        ['category', 'field', 'indicator', 'unit', 'aggregation', 'source'],
        axis=1).dropna()
    # print(dfclean)

    # stack dataframe
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid', 'year', 'value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack)

    # join dataframe for database
    dfdb = dfstack.join(dfunit, on='nid')
    dfdb.index.names = ['dfid']
    dfdb['pathway'] = fns['pathway']
    dfdb['framework'] = fns['framework']
    dfdb['version'] = fns['version']
    dfdb['region'] = region
    dfdb['updated'] = fns['day']
        # (datetime.datetime.fromtimestamp(time.time())
            # .strftime('%Y-%m-%d %H:%M:%S'))
    # print(dfdb)

    # i/o
    if fns['io'] == "Input":
        db_table = db_table_input
    else:   db_table = db_table_output

    # copy dataframe to database
    dfdb.to_sql(con=con,
                schema=db_schema,
                name=db_table,
                if_exists='append',
                index=True)
    log.info('......sheet {} sucessfully imported...'.format(region))


if __name__ == '__main__':
    # logging
    log = logger()
    start_time = time.time()
    log.info('script started...')
    log.info('...file: {}'.format(filename))
    fns = reeem_filenamesplit(filename)
    log.info('...pathway: {}'.format(fns['pathway']))
    log.info('...model: {}'.format(fns['model']))
    log.info('...framework: {}'.format(fns['framework']))
    log.info('...version: {}'.format(fns['version']))
    log.info('...i/o: {}'.format(fns['io']))
    log.info('...regions: {}'.format(regions))
    log.info('...establish database connection...')

    # connection
    con = reeem_session()
    log.info('...read file(s)...')

    # import
    for region in regions:
        times_paneu_2_reeem_db(filename, fns, empty_rows,
                               db_schema, region, con)

    # scenario log
    scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                 os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
