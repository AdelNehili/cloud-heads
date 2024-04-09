import pandas as pd
import matplotlib.pyplot as plt

# Load your DataFrame as 'df'
df = pd.read_csv("transactions.csv", delimiter=';', encoding='utf-8-sig')

# Convert 'Date valeur' to datetime and sort
df['Date valeur'] = pd.to_datetime(df['Date valeur'], format='%d-%m-%y')
df.sort_values('Date valeur', inplace=True)
df = df[df['Date valeur'] > pd.Timestamp("2023-08-01") ]


df = df[(df['Nom de la contrepartie'] == "Google Ireland Limited") | (df['Nom de la contrepartie'] == "KHATTABI OUAFAE")]


# Calculate cumulative sum of 'Montant'
df["Montant"].iloc[0] = df["Montant"].iloc[0] #Add an initial value
df['Cumulative Montant'] = df['Montant'].cumsum()

# Plotting using pandas
df.plot(kind='line', x='Date valeur', y='Cumulative Montant', )
plt.plot(df["Date valeur"], df["Cumulative Montant"],linestyle = "")
plt.title("Montant cumulé en focntion du temps")
plt.xlabel('Date valeur')
plt.ylabel('Cumulative Montant')
plt.show()
