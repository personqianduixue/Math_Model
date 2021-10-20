import pandas as pd
import numpy as np
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer


#read the data
hairdryer=pd.read_csv('Problem_C_Data/hair_dryer.tsv',sep='\t')
microwave=pd.read_csv('Problem_C_Data/microwave.tsv',sep='\t')
pacifier=pd.read_csv('Problem_C_Data/pacifier.tsv',sep='\t')

#remove unrelated data
microwave=microwave[microwave.product_title.str.contains('microwave')]
hairdryer=hairdryer[hairdryer.product_title.str.contains('dryer')]
pacifier=pacifier[pacifier.product_title.str.contains('pacifier')]

#function: convert review to sentiment value
sid = SentimentIntensityAnalyzer()
def sentiquantify(sen):
    score = sid.polarity_scores(sen)
    score=score['compound']
    return score

#dataprocess
def dataprocess(df):
    df['review_headline']=df['review_headline'].apply(str)
    df['review_body']=df['review_body'].apply(str)
    df['review']=df['review_headline']+'. '+df['review_body']
    df['total_sentiscore']=df['review'].apply(sentiquantify)
    df['review']=df['review'].str.replace("[^a-zA-Z#]", " ")

dataprocess(hairdryer)
dataprocess(microwave)
dataprocess(pacifier)

hairdryer['sentiment']=hairdryer['total_sentiscore'].apply(lambda x: 'positive' if x>=0 else 'negtive')
microwave['sentiment']=microwave['total_sentiscore'].apply(lambda x: 'positive' if x>=0 else 'negtive')
pacifier['sentiment']=pacifier['total_sentiscore'].apply(lambda x: 'positive' if x>=0 else 'negtive')

#save data
pacifier.to_excel('pacifier_2.xlsx')
hairdryer.to_excel('hairdryer_2.xlsx')
microwave.to_excel('microwave_2.xlsx')