import matplotlib.pyplot as plt

input_sizes = list(range(4, 2049, 4))
runtimes_program1 = list(range(1,513))
runtimes_program2 = list(range(4,2049, 4))
runtimes_program3 = list(range(1,513))

# Check that the lists are all the same length
assert len(input_sizes) == len(runtimes_program1) == len(runtimes_program2) == len(runtimes_program3)

# Set the plot style
plt.style.use('seaborn-v0_8-whitegrid')

# Create the plot
fig, ax = plt.subplots()

# Define modern color palette
colors = ['#4C72B0', '#55A868', '#C44E52']

# Plot the runtimes with distinct styles (without markers)
ax.plot(input_sizes, runtimes_program1, linestyle='-', color=colors[0], label='Program 1')
ax.plot(input_sizes, runtimes_program2, linestyle='--', color=colors[1], label='Program 2')
ax.plot(input_sizes, runtimes_program3, linestyle='-.', color=colors[2], label='Program 3')

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
