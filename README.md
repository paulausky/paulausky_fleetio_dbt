### Patricia Paulausky's test repository for Fleetio Senior Analytics Engineer Job App 

Steps Taken:\
1. Look through available data to see general quality and whats available 
2. Review stakeholder questions
3. Come up with a rough idea of what can be answered/ which tables we could leverage to answer it 
4. Design a top-down approach where - given the available data - how would we want to visualize answers to these questions? What would make the most sense in terms of streamlining this info for stakeholders? How are stakeholders going to use this information?
5. Design cleaned models to support the reporting we would like to build 

Stakeholder questions:\
1. How many leads were converted by different time grains (day, week, and month)?
		-- leads (cleaned, with some additional columns)\
		-- bar chart: bar chart of converted counts by day, week, month\
		-- additional visuals: max converted count day/week/month for comparison, YoY/MoM/WoW comparison\
2. Which lead sources generated the most converted leads at different time grains (day, week, and month)?
		-- leads (cleaned, with some additional columns)\
		-- bar chart, stacked bar chart: max converted count day/week/month, YoY, MoM, WoW\

3. What are some possible drivers of lead conversion? 
		-- time between creation of lead and time for creation timestamp of opportunity (avg, median for conv/noncov)\
		-- time between creation of lead and time for closed timestamp or opportunity (avg, median for conv/noncov)\
		-- source (top 5 conv/noncov)\
		-- industry (top 5 conv/noncov)\
		-- fleet size (top 5 conv/noncov)\
		-- job title for our lead (top 5 conv/noncov)\
		-- geographic location top 5 conv/noncov) 
4. What are some possible drivers of closed/won opportunities?
		-- need to combine accounts and opportunites\

Seed Overview:\
accounts: id, industry, fleet size\
contacts: contact info, account id, lead id\
leads: contact info, conversion time, source (5 distinct), industry, fleet size, job title of contact\
opportunites: closed/won, geographic locations\