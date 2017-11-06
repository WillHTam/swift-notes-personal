Here’s where a little bit of iOS magic comes in: if you look at the Settings app, you’ll see it can fit only about 12 rows on the screen at any given time, depending on the size of your phone. To save CPU time and RAM, iOS only creates as many rows as it needs to work. When one rows moves off the top of the screen, iOS will take it away and put it into a reuse queue ready to be recycled into a new row that comes in from the bottom. This means you can scroll through hundreds of rows a second, and iOS can behave lazily and avoid creating any new table view cells – it just recycles the existing ones.

This functionality is baked right into iOS, and it’s exactly what our code does on this line:

`let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)`
That creates a new constant called cell by dequeuing a recycled cell from the table. We have to give it the identifier of the cell type we want to recycle, so we enter the same name we gave Interface Builder: “Picture”. We also pass along the index path that was requested; this gets used internally by the table view.

That will return to us a table view cell we can work with to display information. You can create your own custom table view cell designs if you want to (more on that much later!), but we’re using the built-in Basic style that has a text label. That’s where line two comes in: it give the text label of the cell the same text as a picture in our array. Here’s the code again:

`cell.textLabel?.text = pictures[indexPath.row]`
The cell has a property called textLabel, but it’s optional: there might be a text label, or there might not be – if you had designed your own, for example. Rather than write checks to see if there is a text label or not, Swift lets us use a question mark – textLabel? – to mean “do this only if there is an actual text label there, or do nothing otherwise.”

We want to set the label text to be the name of the correct picture from our pictures array, and that’s exactly what the code does. indexPath.row will contain the row number we’re being asked to load, so we’re going to use that to read the corresponding picture from pictures, and place it into the cell’s text label.

The last line in the method is return cell. Remember, this method expects a table view cell to be returned, so we need to send back the one we created – that’s what the return cell does.

With those two pretty small methods in place, you can run your code again now and see how it looks. All being well you should now see 10 table view cells, each one with a different picture name inside. If you click on one of them it will turn gray, but nothing else will happen. Let’s fix that now…
