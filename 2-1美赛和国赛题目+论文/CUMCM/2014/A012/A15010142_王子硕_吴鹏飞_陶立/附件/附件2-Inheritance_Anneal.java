import java.util.*;

public class test9 {
	private static String Time[] = { "0", "20", "50", "100", "150", "200",
			"240", "290", "320", "400", "450", "490" };
	private static int verticalspeed[] = { 1400, 1600, 1550, 1300, 1700, 1000, 1100, 800, 700, 40,
			200, 400 };
	private static int horizonspeed[] = { 0, 10, 15, 10, 5, 3, 0, -20, -30, -32, -35, -32, -21,
			-11, 0 };
	private static int b2[] = { 98, 78, 63, 50, 40, 33 };
	private static int thrust[] = { 7500,7500,7500,7500,7500,7500,7500,7500,7500,7500,7500,7500 };
	private static int angle[] = { 85, 85, 84, 82, 80, 78, 77, 75, 74, 72, 68, 65 };
	private int timeNum = Time.length; 
	private int popSize = 50; 
	private int maxgens = 10000; 
	private double pxover = 0.8; 
	private double pmultation = 0.05; 
	private long[][] distance = new long[timeNum][timeNum];
	private int range = 2000; 

	private class genotype {
		int city[] = new int[timeNum]; 
		long fitness; 
		double selectP; 
		double exceptp; 
		int isSelected; 
	}

	private genotype[] citys = new genotype[popSize];

	/**
	 * 构造函数，初始化种群
	 */
	public test9() {
		for (int i = 0; i < popSize; i++) {
			citys[i] = new genotype();
			int[] num = new int[timeNum];
			for (int j = 0; j < timeNum; j++)
				num[j] = j;
			int temp = timeNum;
			for (int j = 0; j < timeNum; j++) {
				int r = (int) (Math.random() * temp);
				citys[i].city[j] = num[r];
				num[r] = num[temp - 1];
				temp--;
			}
			citys[i].fitness = 0;
			citys[i].selectP = 0;
			citys[i].exceptp = 0;
			citys[i].isSelected = 0;
		}
		initDistance();
	}

	/**
	 * 计算每个种群每个基因个体的适应度，选择概率，期望概率，和是否被选择。
	 */
	public void CalAll() {
		for (int i = 0; i < popSize; i++) {
			citys[i].fitness = 0;
			citys[i].selectP = 0;
			citys[i].exceptp = 0;
			citys[i].isSelected = 0;
		}
		CalFitness();
		CalSelectP();
		CalExceptP();
		CalIsSelected();
	}

	/**
	 * 填充，将多选的填充到未选的个体当中
	 */
	public void pad() {
		int best = 0;
		int bad = 0;
		while (true) {
			while (citys[best].isSelected <= 1 && best < popSize - 1)
				best++;
			while (citys[bad].isSelected != 0 && bad < popSize - 1)
				bad++;
			for (int i = 0; i < timeNum; i++)
				citys[bad].city[i] = citys[best].city[i];
			citys[best].isSelected--;
			citys[bad].isSelected++;
			bad++;
			if (best == popSize || bad == popSize)
				break;
		}
	}

	/**
	 * 交叉主体函数
	 */
	public void crossover() {
		int x;
		int y;
		int pop = (int) (popSize * pxover / 2);
		while (pop > 0) {
			x = (int) (Math.random() * popSize);
			y = (int) (Math.random() * popSize);

			executeCrossover(x, y);// x y 两个体执行交叉
			pop--;
		}
	}

	/**
	 * 执行交叉函数
	 * 
	 * @param 个体x
	 * @param 个体y
	 *            对个体x和个体y执行佳点集的交叉
	 */
	private void executeCrossover(int x, int y) {
		int dimension = 0;
		for (int i = 0; i < timeNum; i++)
			if (citys[x].city[i] != citys[y].city[i]) {
				dimension++;
			}
		int diffItem = 0;
		double[] diff = new double[dimension];

		for (int i = 0; i < timeNum; i++) {
			if (citys[x].city[i] != citys[y].city[i]) {
				diff[diffItem] = citys[x].city[i];
				citys[x].city[i] = -1;
				citys[y].city[i] = -1;
				diffItem++;
			}
		}

		Arrays.sort(diff);

		double[] temp = new double[dimension];
		temp = gp(x, dimension);

		for (int k = 0; k < dimension; k++)
			for (int j = 0; j < dimension; j++)
				if (temp[j] == k) {
					double item = temp[k];
					temp[k] = temp[j];
					temp[j] = item;

					item = diff[k];
					diff[k] = diff[j];
					diff[j] = item;
				}
		int tempDimension = dimension;
		int tempi = 0;

		while (tempDimension > 0) {
			if (citys[x].city[tempi] == -1) {
				citys[x].city[tempi] = (int) diff[dimension - tempDimension];

				tempDimension--;
			}
			tempi++;
		}

		Arrays.sort(diff);

		temp = gp(y, dimension);

		for (int k = 0; k < dimension; k++)
			for (int j = 0; j < dimension; j++)
				if (temp[j] == k) {
					double item = temp[k];
					temp[k] = temp[j];
					temp[j] = item;

					item = diff[k];
					diff[k] = diff[j];
					diff[j] = item;
				}

		tempDimension = dimension;
		tempi = 0;

		while (tempDimension > 0) {
			if (citys[y].city[tempi] == -1) {
				citys[y].city[tempi] = (int) diff[dimension - tempDimension];

				tempDimension--;
			}
			tempi++;
		}

	}

	/**
	 * @param individual
	 *            个体
	 * @param dimension
	 *            维数
	 * @return 佳点集 (用于交叉函数的交叉点） 在executeCrossover()函数中使用
	 */
	private double[] gp(int individual, int dimension) {
		double[] temp = new double[dimension];
		double[] temp1 = new double[dimension];
		int p = 2 * dimension + 3;

		while (!isSushu(p))
			p++;

		for (int i = 0; i < dimension; i++) {
			temp[i] = 2 * Math.cos(2 * Math.PI * (i + 1) / p)
					* (individual + 1);
			temp[i] = temp[i] - (int) temp[i];
			if (temp[i] < 0)
				temp[i] = 1 + temp[i];

		}
		for (int i = 0; i < dimension; i++)
			temp1[i] = temp[i];
		Arrays.sort(temp1);
		// 排序
		for (int i = 0; i < dimension; i++)
			for (int j = 0; j < dimension; j++)
				if (temp[j] == temp1[i])
					temp[j] = i;
		return temp;
	}

	/**
	 * 变异
	 */
	public void mutate() {
		double random;
		int temp;
		int temp1;
		int temp2;
		for (int i = 0; i < popSize; i++) {
			random = Math.random();
			if (random <= pmultation) {
				temp1 = (int) (Math.random() * (timeNum));
				temp2 = (int) (Math.random() * (timeNum));
				temp = citys[i].city[temp1];
				citys[i].city[temp1] = citys[i].city[temp2];
				citys[i].city[temp2] = temp;

			}
		}
	}

	/**
	 * 初始化各状态之间的距离
	 */
	private void initDistance() {
		for (int i = 0; i < timeNum; i++) {
			for (int j = 0; j < timeNum; j++) {
				distance[i][j] = Math.abs(i - j);
			}
		}
	}

	/**
	 * 计算所有状态序列的适应度
	 */
	private void CalFitness() {
		for (int i = 0; i < popSize; i++) {
			for (int j = 0; j < timeNum - 1; j++)
				citys[i].fitness += distance[citys[i].city[j]][citys[i].city[j + 1]];
			citys[i].fitness += distance[citys[i].city[0]][citys[i].city[timeNum - 1]];
		}
	}

	/**
	 * 计算选择概率
	 */
	private void CalSelectP() {
		long sum = 0;
		for (int i = 0; i < popSize; i++)
			sum += citys[i].fitness;
		for (int i = 0; i < popSize; i++)
			citys[i].selectP = (double) citys[i].fitness / sum;

	}

	/**
	 * 计算期望概率
	 */
	private void CalExceptP() {
		for (int i = 0; i < popSize; i++)
			citys[i].exceptp = (double) citys[i].selectP * popSize;
	}

	/**
	 * 计算该状态序列是否较优，较优则被选择，进入下一代
	 */
	private void CalIsSelected() {
		int needSelecte = popSize;
		for (int i = 0; i < popSize; i++)
			if (citys[i].exceptp < 1) {
				citys[i].isSelected++;
				needSelecte--;
			}
		double[] temp = new double[popSize];
		for (int i = 0; i < popSize; i++) {
			temp[i] = citys[i].exceptp * 10;
		}
		int j = 0;
		while (needSelecte != 0) {
			for (int i = 0; i < popSize; i++) {
				if ((int) temp[i] == j) {
					citys[i].isSelected++;
					needSelecte--;
					if (needSelecte == 0)
						break;
				}
			}
			j++;
		}

	}

	/**
	 * @param x
	 * @return 判断一个数是否是素数的函数
	 */
	private boolean isSushu(int x) {
		if (x < 2)
			return false;
		for (int i = 2; i <= x / 2; i++)
			if (x % i == 0 && x != 2)
				return false;

		return true;
	}

	/**
	 * @param x
	 *            数组
	 * @return x数组的值是否全部相等，相等则表示x.length代的最优结果相同，则算法结束
	 */
	private boolean isSame(long[] x) {
		for (int i = 0; i < x.length - 1; i++)
			if (x[i] != x[i + 1])
				return false;
		return true;
	}

	public int[] sort(int a[]) {
		for (int i = 1; i < a.length; i++) {// 外层循环从i=1开始
			for (int j = 0; j < a.length - 1; j++) {// 内层循环从i=0开始
				if (a[j] > a[j + 1]) {// 比较数组元素相邻两个元素的大小，如果前者大于后者就将两个值进行交换
					int temp1 = a[j];
					a[j] = a[j + 1];
					a[j + 1] = temp1;
				}
			}
		}
		return a;
	}

	/**
	 * 打印任意代最优的路径序列
	 */
	private void printBestRoute() {
		CalAll();
		long temp = citys[0].fitness;
		int index = 0;
		for (int i = 1; i < popSize; i++) {
			if (citys[i].fitness < temp) {
				temp = citys[i].fitness;
				index = i;
			}
		}
		for (int j = 0; j < timeNum; j++) {
			String cityEnd[] = { Time[citys[index].city[j]] };
			for (int m = 0; m < cityEnd.length; m++) {
				System.out.print(cityEnd[m] + " ");
			}
		}
		System.out.println();
	}

	/**
	 * 算法执行
	 */
	public void run() {
		long[] result = new long[range];
		// result初始化为所有的数字都不相等
		for (int i = 0; i < range; i++)
			result[i] = i;
		int index = 0; // 数组中的位置
		int num = 1; // 第num代
		while (maxgens > 0) {
			CalAll();
			pad();
			crossover();
			mutate();
			maxgens--;
			long temp = citys[0].fitness;
			for (int i = 1; i < popSize; i++)
				if (citys[i].fitness < temp) {
					temp = citys[i].fitness;
				}
			result[index] = temp;
			if (isSame(result))
				break;
			index++;
			if (index == range)
				index = 0;
			num++;
		}
		printBestRoute();
	}

	/**
	 * @param a
	 *            开始时间
	 * @param b
	 *            结束时间
	 */
	public static void CalTime(Calendar a, Calendar b) {
		long x = b.getTimeInMillis() - a.getTimeInMillis();
		long y = x / 1000;
		x = x - 1000 * y;
		System.out.println("算法执行时间：" + y + "." + x + " 秒");
	}

	/**
	 * 程序入口
	 */
	public static void main(String[] args) {
		Arrays.sort(verticalspeed);
		System.out.println("时间:");
		for(int i=0;i<Time.length;i++)
		{
			System.out.print(Time[i]+" ");
		}
		System.out.println();
		System.out.println("垂直速度");
		for(int i=0;i<verticalspeed.length;i++)
		{
			System.out.print(verticalspeed[i]+" ");
		}
		System.out.println();
		System.out.println("水平速度");
		for(int i=0;i<horizonspeed.length;i++)
		{
			System.out.print(horizonspeed[i]+" ");
		}
		System.out.println();
		System.out.println("推力");
		for(int i=0;i<thrust.length;i++)
		{
			System.out.print(thrust[i]+" ");
		}
		System.out.println();
		System.out.println("姿态角");
		for(int i=0;i<angle.length;i++)
		{
			System.out.print(angle[i]+" ");
		}
	}
}