# Learning Graph ARMA Processes from Time-Vertex Spectra

This repository contains the code implementation of a research paper titled ["Learning Graph ARMA Processes from Time-Vertex Spectra"](https://arxiv.org/abs/2302.06887). The paper addresses the problem of learning parametric stochastic graph processes for time-varying graph signals from partially observed realizations. The code estimates the joint time-vertex power spectral density of the process and fits it to a graph autoregressive moving average (graph ARMA) model using convex optimization techniques.  The missing signal values can be estimated based on the learnt model. The missing signal values can be estimated based on the learnt model.
## Requirements

The code is written in MATLAB and requires the following toolboxes:
- [CVX: A MATLAB-based modeling system for convex optimization .](http://cvxr.com/cvx/download/)
## Usage
* Run `cvx_startup.m` file before running the main script.
* Run `experiments\syntheticdata\numberofrealizations\main.m` file for the number of realizations experiment.
## License

This project is licensed under the MIT License. Please see the [LICENSE](LICENSE) file for more details.
