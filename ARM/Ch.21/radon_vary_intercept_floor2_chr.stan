data {
  int<lower=0> N; 
  int<lower=0> J; 
  vector[N] y;
  vector[N] u;
  vector[N] x;
  vector[N] x_mean;
  int county[N];
} 
parameters {
  vector[3] b;
  vector[J] eta;
  real<lower=0> sigma_y;
  real<lower=0> sigma_a;
  real mu_a;
} 
transformed parameters {
  vector[N] y_hat;
  vector[J] a;

  a <- mu_a + sigma_a * eta;

  for (i in 1:N)
    y_hat[i] <- a[county[i]] + u[i] * b[1] + x[i] * b[2] + x_mean[i] * b[3];
}
model {
  mu_a ~ normal(0, 100);
  eta ~ normal(0, 1);

  b ~ normal(0, 100);

  y ~ normal(y_hat, sigma_y);
}
