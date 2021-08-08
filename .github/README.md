# climate-model
 Climate model for my Earth Systems 2020/2021 unit, written in R. It's designed to be used in RStudio/vs-code, and includes the requesite project files for both
 
# Usage
- To run the model, execute the ``10Combined.r`` file, which imports all other files
- No libraries are required for the default configuration, although ``ggplot2`` is required for graph drawing
- By default, when executed the model will 11 times with a series of different configurations. To modify these, edit the ``runMultipleModels()`` list in ``6Interface.r``. It will also create a table with the columns that were required for the unit, as well as a number of other outputs that vary on a yearly basis over the run of the model.
- Chart drawing is disabled by default, but if required two example ``ggplot2`` charts are included at the bottom of ``6Interface.r``
- Default config variables can be found in ``4Config.r`` and are documented there. All variables in the ``CONFIG`` list can be modified on a per-run basis when using ``runMultipleModels()`` by passing a override table. It is recommended to keep ``runYears`` and ``startYear`` constant for comparison purposes, but it will still run if these are changed
