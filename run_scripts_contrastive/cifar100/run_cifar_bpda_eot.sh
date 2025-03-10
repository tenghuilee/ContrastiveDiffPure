#!/usr/bin/env bash

cuda_index=$1
SEED1=$2
SEED2=$3

for t in 100; do
  for adv_eps in 0.031373; do
    for seed in $SEED1; do
      for data_seed in $SEED2; do

        CUDA_VISIBLE_DEVICES=$cuda_index python eval_sde_adv_bpda_contrastive.py --exp ./exp_results_cifar100_contrastive_wideresnet-28-10 --config cifar100.yml \
          -i cifar100-robust_adv-$t-eps$adv_eps-200x1-bm0-t0-end1e-5-cont-bpda \
          --t $t \
          --adv_eps $adv_eps \
          --adv_batch_size 10 \
          --num_sub 200 \
          --domain cifar100 \
          --classifier_name cifar100-wideresnet-28-10 \
          --seed $seed \
          --data_seed $data_seed \
          --diffusion_type sde \
          --score_type score_sde \
          --contrastiveive_classifier cifar100-wideresnet-28-10 \
          --constructive_n_classes 100 \
          --constructive_optim_lr 0.01 \
          --constructive_drift_min 40 \
          --constructive_drift_max 100000 \

      done
    done
  done
done
