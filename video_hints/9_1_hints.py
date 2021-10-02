# 9-1


f['log_price'] = np.log(f['price'])
f['log_totsp'] = np.log(f['totsp'])
f['log_kitsp'] = np.log(f['kitsp'])
f['log_livesp'] = np.log(f['livesp'])
f['remsp'] = f['totsp'] - f['livesp'] - f['kitsp']
f['log_remsp'] = np.log(f['remsp'])



y = f['log_price']
Xa = f[['log_totsp']]
Xb = f[['log_livesp', 'log_kitsp', 'log_remsp']]


Xa_train, Xa_test, y_train, y_test = train_test_split(Xa, y, test_size=0.2, random_state=777)
Xb_train, Xb_test, y_train, y_test = train_test_split(Xb, y, test_size=0.2, random_state=777)

mod_a = LinearRegression().fit(Xa_train, y_train)
mod_b = LinearRegression().fit(Xb_train, y_train)



mod_a.coef_


y_hat_a = mod_a.predict(Xa_test)
y_hat_b = mod_b.predict(Xb_test)


mean_squared_error(y_hat_a, y_test)


CV = KFold(5, shuffle=True, random_state=777)
all_mse_a = cross_val_score(mod_a, Xa, y, scoring='neg_mean_squared_error', cv=CV)
np.mean(all_mse_a)


