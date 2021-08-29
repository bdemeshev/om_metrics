# 9-2


dependent ~ exog + [endog ~ instr]




mod = IV2SLS.from_formula("lscrap ~ 1 + [hrsemp ~ grant]", deltas)
res_iv = mod.fit(cov_type="unadjusted") # 'robust'
res_iv.summary()


qplot(data = h, x = price, y = packs)
h95 = filter(h, year == '1995')

h2 = mutate(h95,
            rprice = price / cpi,
            rincome = income / (cpi * population),
            tdiff = (taxs - tax) / cpi)
qplot(data = h2, x = price, y = packs)
qplot(data = h2, x = rprice, y = packs)

# МНК
model_0 = lm(data = h2, log(packs) ~ log(rprice))
summary(model_0)


# 2МНК руками:
stage_1 = lm(data = h2, log(rprice) ~ tdiff)
stage_1
h3 = mutate(h2, log_price_hat = fitted(stage_1))
stage_2 = lm(data = h3, log(packs) ~ log_price_hat)

stage_2
summary(stage_2) # se лгут!

model_iv = ivreg(data = h2,
      log(packs) ~ log(rprice) | tdiff)
summary(model_iv)

model_iv_hc = iv_robust(data = h2,
                 log(packs) ~ log(rprice) | tdiff)
summary(model_iv_hc)


huxreg(model_0, model_iv, model_iv_hc)


model_iv_hc2 = iv_robust(data = h2,
      log(packs) ~ log(rprice) + log(rincome)
      | tdiff + log(rincome))
summary(model_iv_hc2)



cig['rprice'] = cig['price'] / cig['cpi']
cig['rincome'] = cig['income'] / cig['cpi'] / cig['population']
cig['tdiff'] = (cig['taxs'] - cig['tax']) / cig['cpi']


c95 = cig[cig['year'] == 1995]

sns.relplot(data=c95, x='rprice', y='packs');

