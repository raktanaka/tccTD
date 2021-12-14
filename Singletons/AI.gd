extends Node

#Guide used: https://towardsdatascience.com/genetic-algorithm-implementation-in-python-5ab67bb124a6?gi=f8ce632ced77

## chromosome [enemy_type, delay_time]

var Enemy_Type = ['EnemyRed', 'EnemyGreen', 'EnemyBlue', 'EnemyYellow', 'EnemyPurple', 'EnemyOrange']

var Enemy_Path = ['Path1', 'Path2']

var Max_time = 2

#var population = [['EnemyRed', 1], ['EnemyGreen', 1], ['EnemyBlue', 1], ['EnemyYellow', 1], ['EnemyPurple', 1], ['EnemyOrange', 1]]
var population = [['EnemyRed', 0], ['EnemyGreen', 0], ['EnemyBlue', 0], ['EnemyYellow', 0], ['EnemyPurple', 0], ['EnemyOrange', 0], ['EnemyRed', 1], ['EnemyGreen', 1], ['EnemyBlue', 1], ['EnemyYellow', 1], ['EnemyPurple', 1], ['EnemyOrange', 1]]
## receives the results that this generation achieved
## in this example, receives a vector [REACHED_GOAL_BIN, HP_REMAINING]
var population_res = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]

# organize results of population
var id = -1

# inputs of the equation
var n = 12


# index 0, size of the population, index 1, number of genes by individual
var pop_size = [12,2]

# to get random values
var rng = RandomNumberGenerator.new()

var mutation_prob = 1.0 / pop_size[0] #starts at 100%

func _ready():
	population_res.resize (pop_size[0])
	rng.randomize()
	
func f_id ():
	id += 1
	if id >= pop_size[0]:
		id = 0
	return id

# IMPORTANT TO DEFINE THIS FUNCTION FOR EACH GAME
func measure_fitness ():
	pass

#    In this game, we measure the fitness with the time that the enemys survived 
# or if they reached the destination
# Wil: Dar "nota" para a performance do tanque, talvez ponderar
# Média: 5 * % caminho percorrido e 5 * % HP restante
func measure_fitness_TD (result):
	return (result[0] + result[1]) / 2
	
#    In this game, we measure the fitness with the HP that the enemys hit 
# the player
# Wil: Dar "nota" para a performance do asteróide, talvez ponderar
# Média: Se acertou, usar a vida no momento do impacto
# Talvez a distância asteróide-player

func measure_fitness_Asteroids (chromossome):
	pass

func reset (wave):
	mutation_prob = 1.0
	population = wave

# Calculating the fitness value of each solution in the current population.
# The fitness function calculates the sum of products between each input 
# and its corresponding weight.
func cal_pop_fitness(pop):
	var fitness = []
	
	for i in pop:
		fitness.append(measure_fitness_TD(i))
		
	return fitness

# Selecting the best individuals in the current generation as parents for produ-
#cing the offspring of the next generation.
func select_mating_pool(pop, fitness, num_parents):
	print('pop')
	print(pop)
	print('fitness')
	print(fitness)
	print('num_parents')
	print(num_parents)
	var parents = []

	for parent_num in range(num_parents):
		var max_fitness_idx = fitness.find (fitness.max())
		parents.append (pop[max_fitness_idx])
		## make this value the smallest one 
		fitness[max_fitness_idx] = -99999999999

	return parents

## Cross over process, will take half of the genes of each parent.
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
		for i in range (offspring_size[1] - crossover_point):
			child.append (parents [parent2_idx][i + crossover_point])

		offspring.append (child)

	return offspring

# use the 3 functions below (mutation_int, mutation_float, mutation_string) to
# generate random values for the genes of the individual. You need to adapt for
# your specific program
func mutation_int (idx):
	if idx == 1:
		return rng.randi_range(0, 1)
	
func mutation_float (idx):
	# the list of genes available
	var gene
	
	# the index of the chromossome that contains a gene of type float.
	if idx == 1:
		gene = Max_time
	
	return rng.randf_range (-gene, gene)
	
func mutation_string (idx):
	var gene
	if (idx == 0):
		gene = Enemy_Type
		
	var random_index = rng.randi_range (0, gene.size() - 1)
	
	print('mutation')
	print (gene[random_index])
	
	return gene[random_index]
	

# In certain situations in nature mutations can occur and will give more
#diversity to the population 
func mutation(offspring_crossover):
	#mutation chance now decreases as the number of generations increases
	#if mutation_prob >= 0:
	#	mutation_prob -= 0.05
	
	# Mutation changes a single gene in each offspring randomly.
	for idx in range(offspring_crossover.size ()):
		# The random gene to mutate.
		var random_index = rng.randi_range (0, offspring_crossover[idx].size() - 1)
		var mutation_chance = rng.randf()
		
		if mutation_chance >= mutation_prob:
			pass
		
		elif offspring_crossover[idx][random_index] is String:
			offspring_crossover[idx][random_index] = mutation_string (random_index)

		elif offspring_crossover[idx][random_index] is int:
			offspring_crossover[idx][random_index] = mutation_int (random_index)
		
		elif offspring_crossover[idx][random_index] is float:
			offspring_crossover[idx][random_index] += mutation_float (random_index)

	print('offspring crossover')
	print(offspring_crossover)
	return offspring_crossover

func start_experiment():
	var num_parents_mating = 2 * (population.size()/3)
	
	print('population res')
	print (population_res)
	print('num_parents_mating')
	print(num_parents_mating)
	
	# Measuring the fitness of each chromosome in the population.
	var fitness = cal_pop_fitness(population_res)
	
	# Selecting the best parents in the population for mating.
	var parents = select_mating_pool(population, fitness, num_parents_mating)
	
	# Generating next generation using crossover.
	var offspring_size = [pop_size[0] - parents.size(), pop_size[1]]
	
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
