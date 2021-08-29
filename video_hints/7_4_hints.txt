# 7-4 prep


dummies = pd.get_dummies(t[['sex', 'pclass']])
dummies.head()


t_full = pd.concat([t, dummies], axis=1)
t_full.head()

t_full = t_full.dropna(subset=['age', 'sex_male', 'fare', 'pclass_2nd', 'pclass_3rd', 'survived'])
t_full.shape

X = t_full[['age', 'sex_male', 'fare', 'pclass_2nd', 'pclass_3rd']]
y = t_full['survived']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=777)

sk_logit = LogisticRegression(penalty='none').fit(X_train, y_train)

sk_logit.coef_


prob_pred = sk_logit.predict_proba(X_test)[:, 0]

confusion_matrix(y_test, prob_pred > 0.45)

sns.heatmap(confusion_matrix(y_test, prob_pred > 0.4), 
annot=True, fmt='d', cmap='Blues');


plot_roc_curve(sk_logit, X_test, y_test);
FPR = 1 -  specificity = FP / (FP + TN) = 
= FP / cond Negative
TPR = Sencitivity = TP / (TP + FN) = 
= TP / cond Positive


plot_precision_recall_curve(sk_logit, X_test, y_test);
recall = TPR = Sencitivity = TP / (TP + FN) = 
= TP / cond Positive
precision = TP / (TP + FP) =
= TP / predicted Positive





