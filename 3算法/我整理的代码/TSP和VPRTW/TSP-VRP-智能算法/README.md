# Solving-TSP-VRP
A MATLAB Implementation of Heuristic Algorithms to Traveling Salesman Problem and Vehicle Routing Problems.

## Goal
To explore the value of minimum distance that all vehicles travel in each time of route planning. (The type of the objective function can be something other than distance if one wish, such as time, cost, etc.)

## Environment
* MATLAB

## Folder Naming

Folder name structure: `Algorithm Name` + `Problem Name`

* Prefix of the folder name--Algorithms:

| Algorithm Abbreviation | Algorithm Name |
| ------------- | ------------- |
| GA  | Genetic Algorithm  |
| ACO  | Ant Colony Optimization  |
| SA  | Simulated Annealing  |
| HPSO  | Hybrid Particle Swarm Optimization (Genetic Algorithm involved)  |

* Suffix of the folder name--Problems:

| Problem Abbreviation | Problem Name |
| ------------- | ------------- |
| TSP  | Traveling Salesman Problem  |
| DVRP  | Vehicle Routing Problem with travel distance constraint |
| CVRP  | Vehicle Routing Problem with capacity constraint  |
| CDVRP  | Vehicle Routing Problem with travel distance and capacity constraint  |
| VRPTW  | Vehicle Routing Problem with travel distance constraint, capacity constraint, and hard time window constraint |

## Output Result

1. Sample Text Output in the Command Window

```MATLAB
...
Iteration = 90, Min Distance = 204.65 km
Iteration = 91, Min Distance = 204.65 km
Iteration = 92, Min Distance = 204.65 km
Iteration = 93, Min Distance = 204.65 km
Iteration = 94, Min Distance = 204.65 km
Iteration = 95, Min Distance = 204.65 km
Iteration = 96, Min Distance = 204.65 km
Iteration = 97, Min Distance = 204.65 km
Iteration = 98, Min Distance = 204.65 km
Iteration = 99, Min Distance = 204.65 km
Iteration = 100, Min Distance = 204.65 km
-------------------------------------------------------------
Elapsed time is 0.340380 seconds.
Total Distance = 204.653 km
Best Route:
0 -> 5 -> 10 -> 2 -> 0 -> 3 -> 6 -> 9 -> 1 -> 0 -> 7 -> 4 -> 8 -> 0
-------------------------------------------------------------
Route of vehichle No.1: 0 -> 5 -> 10 -> 2 -> 0
Time of arrival: 0 - 46.9 - 59.5 - 159.7 - 216.1 min
Distance traveled: 70.15 km, time elapsed: 216.1 min, load rate: 90.00%;
-------------------------------------------------------------
Route of vehichle No.2: 0 -> 3 -> 6 -> 9 -> 1 -> 0
Time of arrival: 0 - 45.9 - 58 - 72.7 - 97.3 - 138.4 min
Distance traveled: 74.29 km, time elapsed: 138.4 min, load rate: 90.00%;
-------------------------------------------------------------
Route of vehichle No.3: 0 -> 7 -> 4 -> 8 -> 0
Time of arrival: 0 - 48 - 72.1 - 90.6 - 128.2 min
Distance traveled: 60.22 km, time elapsed: 128.2 min, load rate: 90.00%;
-------------------------------------------------------------
```


2. Sample Graph of Optimization Process

![Sample_Graph_of_Optimization_Process](https://github.com/liukewia/Solving-TSP-VRP/blob/master/images/Sample_Graph_of_Optimization_Process.jpg)

3. Sample Graph of TSP Route Map

![Sample_of_TSP_Route_Map](https://github.com/liukewia/Solving-TSP-VRP/blob/master/images/Sample_of_TSP_Route_Map.jpg)

4. Sample Graph of VRP Route Map (Hard time window constraint is considered)

![Sample_of_VRP_Route_Map](https://github.com/liukewia/Solving-TSP-VRP/blob/master/images/Sample_of_VRP_Route_Map.jpg)


## Usage
Pull the source code from `master` and open `Main.m` in either folder (if the file exists) to run that solver.
Edit files in the folder `test_data` to apply the solvers to your own problems.

## License
GNU General Public License (GPL)
