data {
  int<lower=0> N;
  int<lower=0> J; 
  vector[N] y;
  vector[N] time;
  int person[N];
} 
parameters {
  matrix[J,2] a;
  real<lower=0> sigma_y;
  real<lower=0> sigma_a;
  real mu_a;
}
transformed parameters {
  vector[N] y_hat;
  for (i in 1:N)
    y_hat[i] <- a[person[i],1] + a[person[i],2] * time[i];
} 
model {
  mu_a ~ normal(0, 100);
  for (j in 1:J)
    a[j] ~ normal (mu_a, sigma_a);

  y ~ normal(y_hat, sigma_y);
}
