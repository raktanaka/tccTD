extends Node

#Guide used: https://towardsdatascience.com/genetic-algorithm-implementation-in-python-5ab67bb124a6?gi=f8ce632ced77

## chromosome [enemy_type, delay_time]

var population = [['EnemyRed', 1] , ['EnemyGreen', 0.9], ['EnemyGray',0.2] , ['Enemy_tanq',1] , ['EnemyBlue', 0.1] ]

## receives the results that this generation achieved
var population_res = []

# inputs of the equation
var equation_inputs

# Number of the weights we are looking to optimize.
var num_weights

# IMPORTANT TO DEFINE THIS FUNCTION FOR EACH GAME
func measure_fitness ():
	pass
	
#    In this game, we measure the fitness with the time that the enemys survived 
# or if they reached the destination
func measure_fitness_TD (equation_inputs, pop):
	pass

# Calculating the fitness value of each solution in the current population.
# The fitness function calculates the sum of products between each input 
# and its corresponding weight.
func cal_pop_fitness(equation_inputs, pop):
	var fitness = []
	
	for i in pop.size ():
		fitness.append(measure_fitness_TD(equation_inputs, pop))
	return fitness

# Selecting the best individuals in the current generation as parents for produ-
#cing the offspring of the next generation.
func select_mating_pool(pop, fitness, num_parents):
	pass
	var parents = []

	for parent_num in range(num_parents):

		var max_fitness_idx = fitness.find (fitness.max())

		parents[parent_num] = pop [max_fitness_idx]
		
		fitness[max_fitness_idx] = -99999999999

	return parents

func crossover (parents, offspring_size, num_weights):
	var a
	return a

func start_experiment (num_generations):
	var num_parents_mating = 4
	
	var new_population
	
	for generation in range(num_generations):
		# Measuring the fitness of each chromosome in the population.
		var fitness = cal_pop_fitness(equation_inputs, new_population)
		
		# Selecting the best parents in the population for mating.
		var parents = select_mating_pool(new_population, fitness, num_parents_mating)
		
		# Generating next generation using crossover.
		var offspring_size = [pop_size[0] - parents.shape[0], num_weights]
		
		var offspring_crossover = crossover (parents, offspring_size)
 
		# Adding some variations to the offsrping using mutation.
		var offspring_mutation = mutation (offspring_crossover)
		
		# Creating the new population based on the parents and offspring.
		#new_population[0:parents.shape[0], :] = parents
		#new_population[parents.shape[0]:, :] = offspring_mutation
