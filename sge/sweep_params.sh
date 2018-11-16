#!/bin/bash
#
# Sweep the parameter space and echo commands to run at each set point


# Single agent, no interaction. Sweep through eventRate, decayRate, and eventSize
for gs in `seq 0.1 0.1 1.00001`; do
   for ier in `seq 0.0 0.1 3.000001`; do
      for gdr in `seq 0 0.1 1.00001`; do
         echo "java -Dinteraction=4 -Dwidth=1 -Dheight=1 -DstableStepsToStop=0 -Dlonc=1.59 -DloncSD=0.13" \
         " -DindEventsPerStepPerAgent=0 -DgroupEventsPerStep=${ier}" \
         " -DinputFilename=\"\" -DgroupSensitivity=${gs} -DgroupSensitivitySD=0 " \
         "-DgrievanceDecayRate=${gdr} -jar LoncModel.jar -for 11000 -repeat 50 -quiet"
      done
   done
done
