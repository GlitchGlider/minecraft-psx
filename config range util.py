# just a quick py file to make writing range values easier
import pyperclip


beginning = float(input("from what: "))
end = float(input("to what: "))
step = float(input("by what step: "))
values = ""
for i in range(0, int((end - beginning) / step) + 1):
    if values == "":
        values = f"{round((float(beginning) + (i * step)), 2):.2f}"  # changing the .0f .2f ect changes the number of decimal places
    else:
        values = f"{values} {round((float(beginning) + (i * step)), 2):.2f}"
print(f"[{values}] copied")
pyperclip.copy(f"[{values}]")
