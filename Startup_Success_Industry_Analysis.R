
library(ggplot2)
library(viridis)
library(RColorBrewer)
library(dplyr)
library (vcd)

startup_investments <- read.csv("Investments.csv")

#### Initial Exploratory Data Analysis #####

# Create a Stacked bar graph
ind_counts <- table(startup_investments$Industry)
sorted_industries <- names(sort(ind_counts, decreasing = TRUE))
startup_investments$Industry <- factor(startup_investments$Industry, levels = sorted_industries)
ggplot(startup_investments, aes(x = Industry, fill = success_metric_updated)) +
  geom_bar(position = "stack", colour = "black", size = 0.2, width = 0.5) +
  scale_fill_manual(values = c("#dbdcff", "#96ead7", "#ffb3ba")) +
  labs(title = "Success Status Count By Industry", x = "Industry", y = "Status Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, size = 10, hjust = 1))

# Create a Pie chart to show success share of each industry
success_df <- startup_investments[startup_investments$success_metric_updated == 'Successful', c('success_metric_updated', 'Industry')]
Succ_industry_counts <- table(success_df $Industry)
palette <- brewer.pal(length(Succ_industry_counts), "Pastel1")
pie(Succ_industry_counts, labels = paste(names(Succ_industry_counts), "(", round(prop.table(Succ_industry_counts) * 100, 1), "%)"), 
    main = "Success Share By Industry", col = palette)


###### Statistical Analysis ############
# Creating the contingency table
startup_investments$success_metric <- 
  ifelse(startup_investments$success_metric_updated == "Potentially Successful", 
         "Unsuccessful", startup_investments$success_metric_updated)
contingency_table <- table(startup_investments$Industry, 
                           startup_investments$success_metric)

print(contingency_table)

# Checking for expected cell count.
expected <- round(chisq.test(contingency_table)$expected)

print("Expected frequencies:")
print(expected) 

# Check if any expected frequency is less than 5
if(any(expected < 5)) {
  print("Expected frequencies are less than 5, consider collapsing categories or using an alternative test.")
} else {
  print("Expected frequencies are all 5 or greater.")
}

chi_squared_test <- chisq.test(contingency_table)
print(chi_squared_test)

# Cramer's V
assocstats(contingency_table)

# Calculate CI for each Industry proportion ##
conf_int <- list()
total_obs <- numeric(nrow(contingency_table))

for (i in 1:nrow(contingency_table)) {
  industry_data <- contingency_table[i, ]
  total_obs[i] <- sum(industry_data)
  prop_success <- industry_data[1] / total_obs[i]
  conf_interval <- prop.test(x = industry_data[1], n = total_obs[i], conf.level = 0.95)$conf.int
  conf_int[[i]] <- conf_interval
}

for (i in 1:length(conf_int)) {
  cat("Confidence interval for",rownames(contingency_table)[i], ": ", conf_int[[i]], mean(conf_int[[i]]),"\n")
}

# Plot the calculated CI
ci_df <- data.frame(
  Industry = rownames(contingency_table),
  LB = sapply(conf_int, `[`, 1),
  UB = sapply(conf_int, `[`, 2)
)
ci_df$Industry <- paste0(ci_df$Industry, "\n n = ", total_obs)
ci_df$Industry <- factor(ci_df$Industry, levels = rev(ci_df$Industry[order(ci_df$LB)]))
ggplot(ci_df, aes(x = Industry, ymin = LB, ymax = UB, y = (LB + UB)/2)) +
  geom_errorbar(width = 0.2, color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "95% Wald Confidence Interval for Proportion Successful",
       x = "Industry", y = "Proportion of Success") +
  theme_minimal() +
  coord_cartesian(ylim = c(0.2, 0.65)) +
  coord_flip() +
  theme(axis.text.x = element_text(vjust = 1, hjust = 1, size = 10, face = "bold"),
        axis.text.y = element_text(size = 10, face = "bold"),
        axis.line = element_line(color = "lightgray"))