#!/usr/bin/env bash

cuda_index=$1
SEED1=$2
SEED2=$3

for t in 100; do
  for adv_eps in 0.0157; do
    for seed in $SEED1; do
      for data_seed in $SEED2; do

        CUDA_VISIBLE_DEVICES=$cuda_index python eval_sde_adv_contrastive.py --exp ./exp_results_contrastive_resnet18 --config imagenet.yml \
          -i imagenet-robust_adv-$t-eps$adv_eps-bm0-t0-end1e-5-cont-eot20-eotpgd-resnet50 \
          --t $t \
          --adv_eps $adv_eps \
          --adv_batch_size 16 \
          --num_sub 16 \
          --domain imagenet \
          --classifier_name imagenet-resnet50 \
          --seed $seed \
          --data_seed $data_seed \
          --diffusion_type sde \
          --attack_version eotpgd \
          --eot_iter 20 \
          --contrastiveive_classifier imagenet-resnet18 \
          --constructive_n_classes 1000 \
          --constructive_optim_lr 0.01 \
          --constructive_drift_min 0 \
          --contrastive_delta_grad_mul 500 \
          --contrastive_temperature 1.0 \
          --constructive_drift_max 100000 \

      done
    done
  done
done
