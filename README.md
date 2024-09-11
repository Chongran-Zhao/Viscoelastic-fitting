# Viscoelastic Material Deformation Calibration Code

## Overview
This repository contains the code used to **calibrate** the deformation behavior of viscoelastic materials, aiming to provide accurate model predictions that align closely with experimental data.

## Author
**Chongran Zhao**  
*Southern University of Science and Technology, China*  
*Email: [chongranzhao@outlook.com](mailto:chongranzhao@outlook.com)*  
*Date: September 9, 2024*

## Table of Contents
- [Experimental Data](#experimental-data)
- [Continuum Basis](#continuum-basis)
- [Calibration and Validation](#calibration-and-validation)
- [Viscoelastic Theory with Generalized Strains](#viscoelastic-theory-with-generalized-strains)
- [Evaluation Functions (NMAD, MSD, R²)](#evaluation-functions-nmad-msd-r²)
- [References](#references)

## Experimental Data
Two experiments were conducted on Optically Clear Adhesive (OCA) materials:

- **Monotonic Shear Test** at three distinct shear rates.  
  <img src="https://github.com/user-attachments/assets/985eea3f-69f0-458f-9987-b429c0f59235" alt="Monotonic Shear Loading" width="45%">  
  <img src="https://github.com/user-attachments/assets/82bc5fd2-a1bf-43b9-b6eb-007740e928c9" alt="Monotonic Shear Experimental Points" width="45%">

- **Cyclic Shear-Relaxation Test** at three different rates.  
  <img src="https://github.com/user-attachments/assets/90d4189a-062f-40e0-98a7-65fbf0eae96a" alt="Cyclic Shear Relaxation Loading" width="45%">  
  <img src="https://github.com/user-attachments/assets/d742406d-cb14-461a-b080-a210c8cc325e" alt="Cyclic Shear Relaxation Experimental Points" width="45%">

## Continuum Basis
For a deeper understanding of the **continuum basis** used in this study, refer to the following source:

- Holzapfel, G. A. (2002). *Nonlinear Solid Mechanics: A Continuum Approach for Engineering Science.*

## Calibration and Validation
- The `Calibration` folder contains code to simultaneously calibrate all three experimental points at various loading rates.
- The `Calibration-Validation` folder includes code that calibrates two experimental points and then validates the third using optimized parameters.

## Viscoelastic Theory with Generalized Strains
To explore more about the **viscoelastic theory** applied here, including the concept of **generalized strains**, refer to the following paper:

- Liu, J., Guan, J., Zhao, C., & Luo, J. (2024). *A Continuum and Computational Framework for Viscoelastodynamics: III. A Nonlinear Theory.* Computer Methods in Applied Mechanics and Engineering, 430, 117248. [DOI: 10.1016/j.cma.2024.117248](https://doi.org/10.1016/j.cma.2024.117248)

## Evaluation Functions (NMAD, MSD, R²)
The **evaluation functions** used in this repository (e.g., NMAD, MSD, R²) are discussed in detail in the following resource:

- [Fitness Functions Used by MCalibration](https://polymerfem.com/fitness-functions-used-by-mcalibration/)

## References
- Please note that the links provided above may require a stable internet connection. If any issues arise with access, kindly check their validity and try again.

---

Feel free to reach out with any questions or collaboration inquiries. I'm happy to discuss and work together on related topics!
