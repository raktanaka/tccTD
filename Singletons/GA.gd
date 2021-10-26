extends Node

#Guide used: https://towardsdatascience.com/genetic-algorithm-implementation-in-python-5ab67bb124a6?gi=f8ce632ced77

## chromosome [enemy_type, delay_time]

var population = [['EnemyRed', 1] , ['EnemyGreen', 0.9], ['EnemyGray',0.2] , ['Enemy_tanq',1] , ['EnemyBlue', 0.1] ]

## receives the results that this generation achieved
var population_res = []

# inputs of the equation
var equation_inputs

var num_weights = 2  # Number of the weights we are looking to optimize.

var pop = []

# IMPORTANT TO DEFINE THIS FUNCTION FOR EACH GAME
func measure_fitness ():
	pass
	
#    In this game, we measure the fitness with the time that the enemys survived 
# or if they reached the destination
func measure_fitness_TD (equation_inputs, pop):
	pass

### ?
func clone(node: Node) -> void :
	var copy = node.duplicate()
	# see https://docs.godotengine.org/en/3.1/classes/class_object.html#id2
	var properties: Array = node.get_property_list()

	var script_properties: Array = []

	for prop in properties:
		# see https://docs.godotengine.org/en/3.1/classes/class_@globalscope.html#enum-globalscope-propertyusageflags
			# basically here we are getting any of the user-defined script variables that exist, since those apparently don't
			# get copied via `duplicate()`
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == PROPERTY_USAGE_SCRIPT_VARIABLE:
			script_properties.append(prop)

	for prop in script_properties:
		copy.set(prop.name, node[prop.name])

	pop.append(copy)

	
func show_pop_situation():
	print('shoud analise the results...')
	print(pop.size())
	for i in pop :
		print( 'inimigo : ',i.name, 'hp: ', i.hp )

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
	crossover_point = offspring_size[1] / 2
 
	for k in range(offspring_size[0]):
		var child = []

		# Index of the first parent to mate.
		var parent1_idx = k % parents.length()

		# Index of the second parent to mate.
		var parent2_idx = (k + 1) % parents.length()

		# The new offspring will have its first half of its genes taken from the first parent.
		for i in range (crossover_point):
			child.append (parents [parent1_idx][i])

		# The new offspring will have its second half of its genes taken from the second parent.
		for i in range (crossover_point):
			child.append (parents [parent2_idx][i + 1 + crossover_point])
			##maybe  remove + 1

		offspring.append (child)

	return offspring

func mutation(offspring_crossover):

	# Mutation changes a single gene in each offspring randomly.
	for idx in range(offspring_crossover.length()):

		# The random value to be added to the gene.

		random_value = randi_range (-1, 1)

		offspring_crossover[idx, 2] += random_value

	return offspring_crossover

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
 
		# Adding some variations to the offspring using mutation.
		var offspring_mutation = mutation (offspring_crossover)
		
		# Creating the new population based on the parents and offspring.
		var new_population = []

		for i in range (parents.length ())
			new_population.append (parents[i])

		for i in range (offspring_mutation.length ())
			new_population.append (offspring_mutation[i])


## class inimigo:
## var speed
## var base_damage , hp = 100.0 , move_direction = 0
## Y = w1x1 + w2x2 + w3x3 + w4x4 + w5x5 + w6x6
## Y =  hp(speed * ' tempo '+ dano)