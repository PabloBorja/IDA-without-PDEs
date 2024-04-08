# IDA-without-PDEs
This repository contains some exercises related to the paper: 

====================================

Borja, P. "Interconnection and Damping Assignment Passivity-based Control Without Partial Differential Equations." CONTROL 2024: 14th United Kingdom Automatic Control Council (UKACC) International Conference on Control.

====================================

The PDF file "Examples" briefly analyzes four physical systems that can be stabilized using interconnection and damping assignment passivity-based controller (IDA-PBC) without solving partial differential equations.

The folders contain files to simulate the closed-loop systems. There are two MATLAB scripts (which can be run using Octave by commenting the command 'yline') per system. Please run the script [name_system]_simulation.m to simulate the closed-loop dynamics. The fermenter, MEMS, and magnetic levitation systems can also be simulated using the corresponding notebook containing Python3 code. Additionally, there is a notebook running a SageMath kernel to simulate the magnetic levitation system.

Please keep in mind that the objective of the simulations is to illustrate the applicability of the stabilization results. However, almost no tuning work has been done.

If you find mistakes or want to contribute with other examples and methods (e.g., improving the Python or SageMath codes or adding notebooks with R or Julia kernels), please email me at pablo.borjarosales@plymouth.ac.uk

If the material in this repository helps you with your research, please consider citing the abovementioned paper.
