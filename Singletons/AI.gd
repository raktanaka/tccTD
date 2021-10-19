extends Node

var chromosome = [['EnemyRed', 1] , ['EnemyGreen', 0.9], ['EnemyGray',0.2] , ['Enemy_tanq',1] , ['EnemyBlue', 0.1] ]

# inputs of the equation
var equation_inputs

# Number of the weights we are looking to optimize.
var num_weights


# Calculating the fitness value of each solution in the current population.
# The fitness function calculates the sum of products between each input 
# and its corresponding weight.
func cal_pop_fitness(equation_inputs, pop):
	pass
	var fitness = 0
	
	for i in pop.size ():
		fitness += pop[i] * equation_inputs[i]
	return fitness

# Selecting the best individuals in the current generation as parents for produ-
#cing the offspring of the next generation.
func select_mating_pool(pop, fitness, num_parents):
	pass
	var parents = []

	for parent_num in range(num_parents):

		#var max_fitness_idx = numpy.where(fitness == numpy.max(fitness))

		#max_fitness_idx = max_fitness_idx[0][0]

		#parents[parent_num, :] = pop[max_fitness_idx, :]
		print("h")
		#fitness[max_fitness_idx] = -99999999999

	return parents
