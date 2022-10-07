-- Take a look at the data

Select *
From nashvile_housing.nashvile_house
Limit 5;

-- (1) Standerdizing date format
-- First off, adding a new date column

Alter Table nashvile_house
Add SaleDateConverted Date;

-- Turn off safe mode to allow updating of columns.

Set SQL_SAFE_UPDATES = 0;
Update nashvile_house
Set
	SaleDateConverted = str_to_date(SaleDate, '%M %e, %Y')
	where ParcelID IS NOT NULL;

-- (2) Populating the Property address data
-- Breaking out address into individual columns(Address, City, State)

Select 
	substring(PropertyAddress, 1, (position(',' in  PropertyAddress))-1) as Address,
	substring(PropertyAddress, (position(',' in  PropertyAddress))+1, length(PropertyAddress)) as Address
From nashvile_housing.nashvile_house;

-- Create an address column and fill in its values.
Alter table nashvile_house
Add PropertySplitAddress varchar(255);

Update nashvile_house
Set 
	PropertySplitAddress = substring(PropertyAddress, 1, (position(',' in  PropertyAddress))-1);

-- Create a city column and fill in its values.
Alter table nashvile_house
Add PropertySplitCity varchar(255);

Update nashvile_house
Set  
	PropertySplitCity = substring(PropertyAddress, (position(',' in  PropertyAddress))+1, length(PropertyAddress));


-- (3) Transforming the owners address column to addrress, city and state columns

Select substring_index(OwnerAddress, ',', 1),
		substring(substring_index(OwnerAddress, ',', 2), (position(',' in substring_index(OwnerAddress, ',', 2))+2)),
		substring(OwnerAddress, length(substring_index(OwnerAddress, ',', 2))+2, length(OwnerAddress))
From nashvile_housing.nashvile_house;

-- Address column
Alter Table nashvile_house
Add OwnerSplitAddress varchar(255);

Update nashvile_house
Set
	OwnerSplitAddress = substring_index(OwnerAddress, ',', 1);

-- City column 
Alter Table nashvile_house
Add OwnerSplitCity varchar(255);

Update nashvile_house
Set
	OwnerSplitCity = substring(substring_index(OwnerAddress, ',', 2), (position(',' in substring_index(OwnerAddress, ',', 2))+2));
	
    
-- State column
Alter Table nashvile_house
Add OwnerSplitState varchar(255);

Update nashvile_house
Set
	OwnerSplitState = substring(OwnerAddress, length(substring_index(OwnerAddress, ',', 2))+2, length(OwnerAddress));
	

-- (4) Sold as vacant column transformation
-- change Y and N to Yes and No respectively
Update nashvile_house
Set
	SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
						when SoldAsVacant = 'N' Then 'No'
                        Else SoldAsVacant
                        End;
                        

-- Delete Unused Columns
Alter Table nashvile_house
Drop Column OwnerAddress, Drop Column TaxDistrict,
Drop Column PropertyAddress, Drop Column SaleDate;


-- Return to safe mode
SET SQL_SAFE_UPDATES = 1;





