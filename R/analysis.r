# Setup
# -----
#
# The CDSW library includes
# a number of helper functions you can use from within R sessions.

library('cdsw')

# [ggplot2](http://ggplot2.org/) is a great way to make pretty graphs.

library('ggplot2')

# Load Data
# ---------
#
# Download and load Cars93 car data.

system('wget -nc https://raw.github.com/vincentarelbundock/Rdatasets/master/csv/MASS/Cars93.csv')
cars <- read.csv('Cars93.csv')
head(cars)
summary(cars$Type)

# Explore
# -------

qplot(cars$MPG.city, main="Cars MPG City")
qplot(cars$MPG.city, cars$Horsepower,
  main="City MPG vs. Horsepower",
  xlab="City MPG", ylab="Horsepower")
qplot(cars$Wheelbase, cars$Weight,
    main="Wheelbase Vs. Car Weight",
    xlab="Wheelbase", ylab="Car Weight") +
  geom_smooth(method = "loess")


# Model
# -----
#
# Regress City MPG on number of cylinders and weight

fit <- lm(MPG.city ~ Cylinders + Weight, data=cars)
summary(fit)

# Worker Engines
# -----------------
#
# Worker engines run on remote containers and can be networked together
# to run distributed jobs.  Using workers, you can easily scale your analysis
# 100s of cores.  All workers share the same project filesystem, have
# access to a virtual private network, and multiplex their output into
# a single master engine for easy debugging.
#
# The following command launches two workers and runs some code remotely:

# workers <- launch.workers(n=2, cpu=0.2, memory=0.5, code="print('Hello from a CDSW Worker')")

# You can stop workers with `stop.workers()`.  All workers will automatically
# be cleaned up when you stop the session as well (top-right session drop down).
