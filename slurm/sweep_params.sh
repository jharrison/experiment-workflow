#!/bin/bash
#
# Sweep the parameter space and echo commands to run at each set point

seed=100001

# Single agent, no interaction. Sweep through eventRate, decayRate, and eventSize
# Use groupSensitivity as a proxy for event size since it's effectively the same thing,
# which means using group events even though there's only one agent
# for gs in `seq 0.1 0.1 1.00001`; do
#    for ger in `seq 0.0 0.1 3.000001`; do
#       for gdr in `seq 0 0.1 1.00001`; do
#          echo "java -Dinteraction=4 -Dwidth=1 -Dheight=1 -DstableStepsToStop=0 -Dlonc=1.59 -DloncSD=0.13" \
#          " -DindEventsPerStepPerAgent=0 -DgroupEventsPerStep=${ger}" \
#          " -DinputFilename=\"\" -DgroupSensitivity=${gs} -DgroupSensitivitySD=0 " \
#          "-DgrievanceDecayRate=${gdr} -jar LoncModel.jar -for 11000 -repeat 50 -quiet"
#       done
#    done
# done

# Single agent, no interaction. Sweep through eventRate, decayRate, and eventSize
# Use groupSensitivity as a proxy for event size since it's effectively the same thing,
# which means using group events even though there's only one agent
# for gs in `seq 0.1 0.01 1.00001`; do
#    for ger in `seq 0.0 0.1 30.000001`; do
#       echo "java -Dinteraction=4 -Dwidth=1 -Dheight=1 -DstableStepsToStop=0 -Dlonc=1.59 -DloncSD=0.13" \
#       " -DindEventsPerStepPerAgent=0 -DgroupEventsPerStep=${ger}" \
#       " -DinputFilename=\"\" -DgroupSensitivity=${gs} -DgroupSensitivitySD=0 " \
#       "-DgrievanceDecayRate=0.1 -jar LoncModel.jar -for 100 -repeat 1 -quiet"
#    done
# done


# Single agent, no interaction. Sweep through eventRate, decayRate, and eventSize

# for ier in $(seq 0.0 0.004 4.000001); do
#    echo "java -Dinteraction=4 -Dwidth=1 -Dheight=1 -DstableStepsToStop=0 -Dlonc=1.59 -DloncSD=0.13" \
#    " -DindEventsPerStepPerAgent=${ier} -DgroupEventsPerStep=0" \
#    " -DinputFilename=\"\" -DgroupSensitivity=0 -DgroupSensitivitySD=0 " \
#    "-DgrievanceDecayRate=0.1 -jar LoncModel.jar -for 100 -repeat 1 -quiet"
# done


# Sweep over individual events per day, gDecay, and gImpact
for in in 0 1 2; do
   for ier in $(seq 0.05 0.05 2.000001); do
      for gdr in $(seq 0.1 0.1 0.900001); do
         for gi in $(seq 0.0 0.05 0.40001); do
      		echo "java -Dinteraction=${in} -Dlonc=1.59 -Dnoise=0.13 -DstableStepsToStop=250" \
            " -DindEventsPerStepPerAgent=${ier} -DgroupEventsPerStep=0" \
            " -DinputFilename=\"\" -DgroupSensitivity=1 -DgroupSensitivitySD=0 " \
            " -DgrievanceDecayRate=${gdr} -DgrievanceImpact=${gi} " \
            "-jar LoncModel.jar -for 10000 -repeat 50 -quiet -seed $((seed++))"
      	done
      done
   done
done

# for i in $(seq 1 30000); do
#    echo "echo \"task number: \${SLURM_ARRAY_TASK_ID}\""
# done
