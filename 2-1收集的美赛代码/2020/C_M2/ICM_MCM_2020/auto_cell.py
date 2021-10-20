import time


def print_seq(seq, speed=0.5):
    for item in seq:
        if item:
            print('*', end='')
        else:
            print('-', end='')
    print('')
    time.sleep(speed)


class Cell:
    def __init__(self, deepth=31):
        self.ca = [0 if i != 31 else 1 for i in range(64)]
        self.ca_new = []
        self.deepth = deepth

    def process(self):
        print_seq(self.ca)
        for i in range(self.deepth):
            self._rule()
            print_seq(self.ca_new)
            self.ca = self.ca_new
            self.ca_new = []

    def _rule(self):
        for i in range(64):
            if 0 < i < 63:
                if self.ca[i - 1] == self.ca[i + 1]:
                    self.ca_new.append(0)
                else:
                    self.ca_new.append(1)
            elif i == 0:
                if self.ca[1]:
                    self.ca_new.append(1)
                else:
                    self.ca_new.append(0)
            else:
                if self.ca[62]:
                    self.ca_new.append(1)
                else:
                    self.ca_new.append(0)


def main():
    cell = Cell()
    cell.process()


if __name__ == '__main__':
    main()
