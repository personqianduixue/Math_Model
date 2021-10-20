from keras.models import Sequential
from keras.layers.core import Dense, Dropout
from keras.layers.embeddings import Embedding
from keras.layers.recurrent import LSTM

from keras.preprocessing import sequence
from keras.preprocessing.text import Tokenizer

import re   #
import os

import pandas as pd


# class PreprocessData():
class PreprocessData():
    def __init__(self):
        print("create")
        self.y_train, self.train_text = self.read_files("train")
        self.y_test, self.test_text = self.read_files("test")
        print(type(self.train_text))    # class 'list'
        train_text = pd.DataFrame(self.train_text)
        print(train_text)
        return None

    #
    def rm_tags(self, text):  #
        re_tag = re.compile(r'<[^>]+>')  #
        return re_tag.sub('', text)  #

    # read dataset content
    # creates read_files function for reading dataset's folder
    def read_files(self, filetype):
        path = "data/"
        file_list = []

        s1_path = path + filetype + "/s1/"
        for f in os.listdir(s1_path):
            file_list += [s1_path + f]
        s2_path = path + filetype + "/s2/"
        for f in os.listdir(s2_path):
            file_list += [s2_path + f]
        s3_path = path + filetype + "/s3/"
        for f in os.listdir(s3_path):
            file_list += [s3_path + f]
        s4_path = path + filetype + "/s4/"
        for f in os.listdir(s4_path):
            file_list += [s4_path + f]
        s5_path = path + filetype + "/s5/"
        for f in os.listdir(s5_path):
            file_list += [s5_path + f]

        print('read', filetype, 'files:', len(file_list))
        print("file_list")
        print(file_list)

        n = [871, 437, 549, 879, 2712]#5448
        # score:       1            2            3            4            5
        all_labels = ([1] * n[0] + [2] * n[1] + [3] * n[2] + [4] * n[3] + [5] * n[4])########
        all_texts = []
        i = 0
        for fi in file_list:
            i += 1
            print("i: ", i)    #s1,s2--1308
            with open(fi, encoding='utf8') as file_input:
                all_texts += [self.rm_tags(" ".join(file_input.readline()))]
        return all_labels, all_texts

    def preprocess_data(self):
        # y_train, train_text = self.read_files("train")
        # y_test, test_text = self.read_files("test")
        # token creation
        token = Tokenizer(num_words=3800)########
        token.fit_on_texts(self.train_text)
        # transform text to num list
        # train_text = self.train_text
        # test_text = self.test_text
        x_train_seq = token.texts_to_sequences(self.train_text)
        x_test_seq = token.texts_to_sequences(self.test_text)
        # all sequence are 100 length
        x_train = sequence.pad_sequences(x_train_seq, maxlen=380)#######
        x_test = sequence.pad_sequences(x_test_seq, maxlen=380)#######
        return x_train, self.y_train, x_test, self.y_test
# class PreprocessData()


# class MyLSTM():
class MyLSTM():
    def __init__(self, x_train, y_train):
        self.x_train = x_train
        self.y_train = y_train
        self.model = Sequential()

    def create_My_LSTM(self):
        self.model.add(Embedding(
            output_dim=32,
            input_dim=3800,
            input_length=380
        ))
        self.model.add(Dropout(0.2))
        self.model.add(LSTM(32))
        self.model.add(Dense(units=256, activation='relu'))
        self.model.add(Dropout(0.2))
        self.model.add(Dense(units=1, activation='sigmoid'))
        return self.model

    def print_model_summary(self):
        print(self.model.summary())
        return self.model

    def fit_my_lstm(self):
        self.model.compile(
            loss='binary_crossentropy',
            optimizer='adam',
            metrics=['accuracy']
        )
        train_history = self.model.fit(
            self.x_train, self.y_train,
            batch_size=100, epochs=30,
            verbose=2, validation_split=0.2
        )
        return self.model, train_history

    def save_my_lstm_model(self, filepath="./model/MyLSTM_for_MCM_C.h5"):
        self.model.save(filepath)
        return self.model

    def load_my_lstm_model(self, filepath="./model/MyLSTM_for_MCM_C.h5"):
        self.model.load_weights(filepath)
        return self.model
# class MyLSTM():


def train(x_train, y_train, x_test, y_test):
    print()
    my_lstm = MyLSTM(x_train, y_train)
    my_lstm.create_My_LSTM()
    my_lstm.fit_my_lstm()
    my_lstm.print_model_summary()
    model = my_lstm.save_my_lstm_model()
    print("evaluate model")
    scores = model.evaluate(x_test, y_test, verbose=1)
    print(scores[1])
    return model


def test(x_train, y_train, x_test, y_test):
    print("test start")
    my_lstm = MyLSTM(x_train, y_train)
    my_lstm.create_My_LSTM()
    model = my_lstm.load_my_lstm_model()
    my_lstm.print_model_summary()
    # start to predict
    predict = model.predict_classes(x_test)
    print(predict[:10])

    # predict
    predict_classed = predict.reshape(-1)
    predict_vector = pd.DataFrame(predict_classed)
    path = "./data/predict_vector.xlsx"
    predict_vector.to_excel(path, index=False)

    print(predict_classed)
    print("test end")
    return predict_classed


SentimentDict = {
    1: "star_rating: 1", 2: "star_rating: 2", 3: "star_rating: 3",
    4: "star_rating: 4", 5: "star_rating: 5"
}


def display_test_Sentiment(i, test_text, y_test, predict_classed):
    print(test_text[i])
    print(
        'label for real: ', SentimentDict[y_test[i]],
        'prediction results: ', SentimentDict[predict_classed[i]], "。"
    )
    return 0


if __name__ == "__main__":
    print("__main__.start...")
    # pre-processing
    preprocessData = PreprocessData()
    print("preprocessData")
    x_train, y_train, x_test, y_test = preprocessData.preprocess_data()
    '''
     print(x_train)
    df = pd.DataFrame(x_train)
    print("x_train")
    path = "./data/x_train.xlsx"
    df.to_excel(path, index=False)
    print("finished")
    '''
    # print("preprocessData.train_text")
    # print(preprocessData.test_text)
    # df = pd.DataFrame(preprocessData.test_text)
    # print("x_train")
    # path = "./data/test_text.xlsx"
    # df.to_excel(path, index=False)
    # print("finished")

    train(x_train, y_train, x_test, y_test)
    print("predict_classed")
    predict_classed = test(x_train, y_train, x_test, y_test)
    print("display_test_Sentiment")
    display_test_Sentiment(0, preprocessData.test_text, preprocessData.y_test, predict_classed)

    print("__main__.end...")
