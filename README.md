# N-Queens Solver using Genetic Algorithm (MATLAB)

This project implements a Genetic Algorithm (GA) in MATLAB to solve the N-Queens problem: placing `N` queens on an `N×N` chessboard so that no two queens attack each other.

Each candidate solution is encoded as a permutation of column indices (one queen per row), and the GA searches for permutations with zero conflicts.

## Features

- Supports arbitrary `N` (e.g. 8, 20, 50, …)
- Multiple parent selection strategies:
  - Roulette Wheel Selection
  - Tournament Selection
  - Random Selection
- Uniform crossover (order-based) adapted for permutations
- Swap-based mutation
- Cost function counts diagonal and column conflicts
- Visualisation of the final board configuration in MATLAB

## Project Structure

```text
src/
  run_nqueens_ga.m          % main script to configure and run the GA
  nqueen_cost.m             % fitness / cost function
  Mutate.m                  % mutation operator (swap mutation)
  uniformCrossoverByOrder.m % crossover operator for permutations
  RouletteWheelSelection.m  % roulette wheel parent selection
  TournamentSelection.m     % tournament parent selection

results/
  % saved solutions / plots

