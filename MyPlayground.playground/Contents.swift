@IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // Update an existing meal.
            meals[selectedIndexPath.row] = meal
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
        else {
            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}