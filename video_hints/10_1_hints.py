
rq = smf.quantreg('price ~ totsp', data=f).fit(q=0.9)
rq.summary()


res = sns.relplot(data=f, x='totsp', y='price');
x = np.arange(f['totsp'].min(), f['totsp'].max(), 1)
for q_mod in q_mods:
  y = q_mod.params[0] + q_mod.params[1] * x
  res.ax.plot(x, y, linestyle='dotted', color='blue');

