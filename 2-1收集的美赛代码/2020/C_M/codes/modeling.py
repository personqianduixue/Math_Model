
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import nltk
sns.set()
import warnings
warnings.filterwarnings("ignore")
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.dummy import DummyClassifier
from string import punctuation
from sklearn import svm
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from nltk import ngrams
from itertools import chain
from wordcloud import WordCloud
from nltk import FreqDist
import spacy

#read data
hairdryer=pd.read_excel('Problem_C_Data/hair_dryer_2.xlsx')
microwave=pd.read_excel('Problem_C_Data/microwave_2.xlsx')
pacifier=pd.read_excel('Problem_C_Data/pacifier_2.xlsx')

 # selecting top 20 most frequent words
def freq_words(x, terms = 30):
  all_words = ' '.join([text for text in x])
  all_words = all_words.split()
  fdist = FreqDist(all_words)
  words_df = pd.DataFrame({'word':list(fdist.keys()), 'count':list(fdist.values())})

  d = words_df.nlargest(columns="count", n = terms) 
  plt.figure()
  ax = sns.barplot(data=d, x="count" , y = "word")
  ax.set(ylabel = 'word')

stop_words = stopwords.words('english')

# function to remove stopwords
def remove_stopwords(rev):
    rev = rev.apply(lambda x: ' '.join([w for w in x.split() if len(w)>2]))
    rev_new = rev.apply(lambda x:" ".join([w for w in x.split() if w not in stop_words]))
    rev_new=rev_new.apply(str.lower)
    return rev_new

# filter noun and adjective
def lemmatization(texts, tags=['NOUN','ADJ']): 
       output = []
       for sent in texts:
             doc = nlp(" ".join(sent)) 
             output.append([token.lemma_ for token in doc if token.pos_ in tags])
       return output

# output the word freq
def out(review):
    review=remove_stopwords(review)
    tokenized_reviews = pd.Series(review).apply(lambda x: x.split())
    review=lemmatization(tokenized_reviews)
    for i in range(len(review)):
        review[i]=' '.join(review[i])
    freq_words(review, 30)
    return review

hairdryer['review']=out(hairdryer['review'])
microwave['review']=out(microwave['review'])
pacifier['review']=out(pacifier['review'])

# 
g1 = sns.catplot(x="star_rating", hue="sentiment", data=hairdryer,
                height=6, kind="count", palette="muted")
g1.set_xlabels('hairdryer rating count')

g2 = sns.catplot(x="star_rating", hue="sentiment", data=microwave,
                height=6, kind="count", palette="muted",hue_order=['positive','negtive'])
g2.set_xlabels('microwave rating count')
g3 = sns.catplot(x="star_rating", hue="sentiment", data=pacifier,
                height=6, kind="count", palette="muted")
g3.set_xlabels('pacifier rating count')

tfidf_n = TfidfVectorizer(ngram_range=(1,2),stop_words = 'english')

# model 
def text_fit(X, y, model,clf_model,coef_show=1):

    X_c = model.fit_transform(X)
    print('# features: {}'.format(X_c.shape[1]))
    X_train, X_test, y_train, y_test = train_test_split(X_c, y, random_state=0)
    print('# train records: {}'.format(X_train.shape[0]))
    print('# test records: {}'.format(X_test.shape[0]))
    clf = clf_model.fit(X_train, y_train)
    acc = clf.score(X_test, y_test)
    print ('Model Accuracy: {}'.format(acc))
    
    if coef_show == 1: 
        w = model.get_feature_names()
        coef = clf.coef_.tolist()[0]
        coeff_df = pd.DataFrame({'Word' : w, 'Coefficient' : coef})
        coeff_df = coeff_df.sort_values(['Coefficient', 'Word'], ascending=[0, 1])
        print('')
        print('-Top 20 positive-')
        print(coeff_df.head(50).to_string(index=False))
        print('')
        print('-Top 20 negative-')        
        print(coeff_df.tail(50).to_string(index=False))
    return coeff_df

# data preprocess
y_dict={1:0,2:0,3:0,4:1,5:1}
y1=hairdryer['star_rating'].map(y_dict)
y2=microwave['star_rating'].map(y_dict)
y3=pacifier['star_rating'].map(y_dict)
x1=hairdryer['review']
x2=microwave['review']
x3=pacifier['review']

#fit the model
text_fit(x1, y1, tfidf_n,LogisticRegression(),coef_show=1)
text_fit(x2, y2, tfidf_n,LogisticRegression(),coef_show=1)
text_fit(x3, y3, tfidf_n,LogisticRegression(),coef_show=1)

text_fit(hairdryer.loc[:,'review'][hairdryer['vine']=='Y'], y1[hairdryer['vine']=='Y'], tfidf_n,LogisticRegression(),coef_show=1)
text_fit(microwave.loc[:,'review'][microwave['vine']=='Y'], y2[microwave['vine']=='Y'], tfidf_n,LogisticRegression(),coef_show=1)
text_fit(pacifier.loc[:,'review'][pacifier['vine']=='Y'], y3[pacifier['vine']=='Y'], tfidf_n,LogisticRegression(),coef_show=1)

def dict(x):
    if x in ['y','Y']:
        return 1
    else:
        return 0

def convert(df):
    df['helping_rate']=(df['helpful_votes']+1)/(df['total_votes']+2)
    #df.loc[:,'helping_rate'][df['total_votes']>=10]*=2

hairdryer['verified_purchase']=hairdryer['verified_purchase'].apply(dict)
hairdryer['vine']=hairdryer['vine'].apply(dict)
pacifier['verified_purchase']=pacifier['verified_purchase'].apply(dict)
pacifier['vine']=pacifier['vine'].apply(dict)
microwave['verified_purchase']=microwave['verified_purchase'].apply(dict)
microwave['vine']=microwave['vine'].apply(dict)

convert(pacifier)
convert(microwave)
convert(hairdryer)

def convert2(df):
    df['vine']=df['star_rating'].apply(lambda x:1.25 if x==2 else 1)
    df['verified_purchase']=df['verified_purchase'].apply(lambda x:0.8 if x==0.5 else 1)

convert2(pacifier)
convert2(microwave)
convert2(hairdryer)

# caculate the score
def caculatescore(df):
    df['total_sentiscore']=(df['total_sentiscore']-df['total_sentiscore'].mean())/df['total_sentiscore'].std()
    df['score']=(df['total_sentiscore']+df['star'])*df['helping_rate']*(df['vine']+df['verified_purchase'])/2
    df['score']=(df['score']-df['score'].min())*100/(df['score'].max()-df['score'].min())

caculatescore(hairdryer)
caculatescore(microwave)
caculatescore(pacifier)

# convert to datetime format
microwave['review_date']=microwave['review_date'].apply(lambda x : pd.to_datetime(x))
hairdryer['review_date']=hairdryer['review_date'].apply(lambda x : pd.to_datetime(x))
pacifier['review_date']=pacifier['review_date'].apply(lambda x : pd.to_datetime(x))

pacifier['score'].groupby(pacifier['date']).mean().plot()  

def convertdate(x):
    return str(x.year)+'-'+str(x.month)

microwave['date']=microwave['review_date'].apply(convertdate)
hairdryer['date']=hairdryer['review_date'].apply(convertdate)

# plot some figures
microwave['score'].groupby(microwave['date']).mean().plot()  
hairdryer['score'].groupby(hairdryer['date']).mean().plot() 
pacifier['total_sentiscore'][pacifier['product_title']=='philips avent bpa free contemporary freeflow pacifier'].groupby(pacifier['date']).mean().plot()  
pacifier['star_rating'][pacifier['product_title']=='philips avent bpa free contemporary freeflow pacifier'].groupby(pacifier['date']).mean().plot() 

pacifier['product_title'].groupby(pacifier['product_title'],).count().sort_values(ascending=False).head(10)

microwave['total_sentiscore'].groupby(microwave['date']).mean().plot()  
microwave['star_rating'].groupby(microwave['date']).mean().plot()  

pacifier['total_sentiscore'][pacifier['product_title']=='philips avent bpa free contemporary freeflow pacifier'].groupby(pacifier['date']).mean().plot() 
pacifier['star_rating'][pacifier['product_title']=='philips avent bpa free contemporary freeflow pacifier'].groupby(pacifier['date']).mean().plot()
plt.legend()


import scipy.stats as stats
stats.kendalltau(data1.values,data2.values)

#output the correlate results
stats.stats.pearsonr(pacifier['star_rating'].groupby(pacifier['date']).mean().values,pacifier['total_sentiscore'].groupby(pacifier['date']).mean().values)
stats.stats.pearsonr(hairdryer['star_rating'].groupby(hairdryer['date']).mean().values,hairdryer['total_sentiscore'].groupby(hairdryer['date']).mean().values)
stats.stats.pearsonr(microwave['star_rating'].groupby(microwave['date']).mean().values,microwave['total_sentiscore'].groupby(microwave['date']).mean().values)
stats.stats.pearsonr(pacifier['star_rating'].groupby(pacifier['date']).mean().values[:-1],pacifier['total_sentiscore'].groupby(pacifier['date']).mean().values[1:])
stats.stats.pearsonr(hairdryer['star_rating'].groupby(hairdryer['date']).mean().values[:-1],hairdryer['total_sentiscore'].groupby(hairdryer['date']).mean().values[1:])
stats.stats.pearsonr(microwave['star_rating'].groupby(microwave['date']).mean().values[:-1],microwave['total_sentiscore'].groupby(microwave['date']).mean().values[1:])