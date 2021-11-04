extends Node

#Guide used: https://towardsdatascience.com/genetic-algorithm-implementation-in-python-5ab67bb124a6?gi=f8ce632ced77

## chromosome [enemy_type, delay_time]

var population = [['EnemyRed', 1], ['EnemyGreen', 0.9], ['EnemyGray', 0.2], ['Enemy_tanq', 1], ['EnemyBlue', 0.1], ['EnemyGray', 0.2]]

## receives the results that this generation achieved
## in this example, receives a vector [REACHED_GOAL_BIN, TIME_ALIVE]
var population_res = [[false, 0], [false, 0], [false, 0], [false, 0], [false, 0], [false, 0]]

# organize results of population
var id = -1

# inputs of the equation
var n = 6

var num_weights = 2  # Number of the weights we are looking to optimize.

# Is right?
var pop_size = [6,2]

func _ready():
	population_res.resize (pop_size[0])
	
func id ():
	id += 1
	if id >= pop_size[0]:
		id = -1
	return id

# IMPORTANT TO DEFINE THIS FUNCTION FOR EACH GAME
func measure_fitness ():
	pass
	
#    In this game, we measure the fitness with the time that the enemys survived 
# or if they reached the destination
func measure_fitness_TD (chromossome):
	if typeof (chromossome) != TYPE_ARRAY:
		return 0
		
	var fit = 0
	
	if chromossome[0] == true:
		fit = 100
	else:
		fit = -100
		
	fit += chromossome[1]
	return fit


# Calculating the fitness value of each solution in the current population.
# The fitness function calculates the sum of products between each input 
# and its corresponding weight.
func cal_pop_fitness(pop):
	var fitness = []
	
	for i in pop.size ():
		fitness.append(measure_fitness_TD(i))
		
	print(fitness)
	return fitness

# Selecting the best individuals in the current generation as parents for produ-
#cing the offspring of the next generation.
func select_mating_pool(pop, fitness, num_parents):
	var parents = []

	for parent_num in range(num_parents):

		var max_fitness_idx = fitness.find (fitness.max())

		parents.append (pop [max_fitness_idx])

		## make this value the smallest one 
		fitness[max_fitness_idx] = -99999999999

	return parents

func crossover (parents, offspring_size):
	var offspring = []

	# The point at which crossover takes place between two parents. Usually, it is at the center.
	var crossover_point = offspring_size[1] / 2
 
	for k in range(offspring_size[0]):
		var child = []

		# Index of the first parent to mate.
		var parent1_idx = k % parents.size()

		# Index of the second parent to mate.
		var parent2_idx = (k + 1) % parents.size()

		# The new offspring will have its first half of its genes taken from the first parent.
		for i in range (crossover_point):
			child.append (parents [parent1_idx][i])

		# The new offspring will have its second half of its genes taken from the second parent.
		for i in range (crossover_point):
			child.append (parents [parent2_idx][i + crossover_point])
			##maybe  remove + 1

		offspring.append (child)

	return offspring

func mutation(offspring_crossover):

	var rng = RandomNumberGenerator.new()
	# Mutation changes a single gene in each offspring randomly.
	for idx in range(offspring_crossover.size()):

		# The random value to be added to the gene.

		var random_value = rng.randi_range (-1, 1)

		offspring_crossover[idx][1] += random_value

	return offspring_crossover

func start_experiment ():
	var num_parents_mating = 4
	
	print (population_res)
	
	# Measuring the fitness of each chromosome in the population.
	var fitness = cal_pop_fitness(population_res)
	
	# Selecting the best parents in the population for mating.
	var parents = select_mating_pool(population, fitness, num_parents_mating)
	
	print (parents)
	
	# Generating next generation using crossover.
	var offspring_size = [pop_size[0] - parents.size(), num_weights]
	
	var offspring_crossover = crossover (parents, offspring_size)

	# Adding some variations to the offspring using mutation.
	var offspring_mutation = mutation (offspring_crossover)
	
	# Creating the new population based on the parents and offspring.
	var new_population = []

	for i in range (parents.size ()):
		new_population.append (parents[i])

	for i in range (offspring_mutation.size ()):
		new_population.append (offspring_mutation[i])
		
	population = new_population

	return new_population

## class inimigo:
## var speed
## var base_damage , hp = 100.0 , move_direction = 0
## Y = w1x1 + w2x2 + w3x3 + w4x4 + w5x5 + w6x6
## Y =  hp(speed * ' tempo '+ dano)
