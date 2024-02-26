import pandas as pd


df1 = pd.read_csv('data_route1_time_periods.csv')
df2 = pd.read_csv('route_data/data_route1_time_periods.csv')


print(set(df1['stop_id'].unique()) - set(df2['stop_id'].unique()))


# print number of elements for each stop_id
print(df1['stop_id'].value_counts())
print(df2['stop_id'].value_counts())