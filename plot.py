import matplotlib.pyplot as plt

import struct

MAX_N = 512
N_RESULTS = MAX_N // 4
def read_results(file_name):

    with open(file_name, "rb") as file:
        data = file.read()

    num_doubles = N_RESULTS
    format_string = f"{num_doubles}d"

    return list(struct.unpack(format_string, data))


input_sizes = list(range(4, MAX_N + 1, 4))
runtimes_program1 = read_results("results_gcc_O0.bin")
runtimes_program2 = read_results("results_gcc_O3.bin")
runtimes_program3 = read_results("results_matrix_mul_function.s.bin")

# Check that the lists are all the same length
assert len(input_sizes) == len(runtimes_program1) == len(runtimes_program2) == len(runtimes_program3)

# Set the plot style
plt.style.use('seaborn-v0_8-whitegrid')

# Create the plot
fig, ax = plt.subplots()

# Define modern color palette
colors = ['#4C72B0', '#55A868', '#C44E52']

# Plot the runtimes with distinct styles (without markers)
ax.plot(input_sizes, runtimes_program1, color=colors[0], label='GCC -O0')
ax.plot(input_sizes, runtimes_program2, color=colors[1], label='GCC -O3')
ax.plot(input_sizes, runtimes_program3, color=colors[2], label='Linear assembly')

# Add shadow effect
ax.fill_between(input_sizes, runtimes_program1, alpha=0.1, color=colors[0])
ax.fill_between(input_sizes, runtimes_program2, alpha=0.1, color=colors[1])
ax.fill_between(input_sizes, runtimes_program3, alpha=0.1, color=colors[2])

# Add titles and labels
ax.set_title('Runtime of Programs', fontsize=15)
ax.set_xlabel('Input Size', fontsize=12)
ax.set_ylabel('Runtime', fontsize=12)

# Add a legend
ax.legend()

# Display the plot
plt.show()
