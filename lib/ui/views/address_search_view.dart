import 'package:tech387/ui/shared/constants.dart';

class AddressSearchView extends StatelessWidget {
  const AddressSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search for a location',
                      border: InputBorder.none,
                    ),
                    onChanged:authProvider.searchAddress
                    
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: authProvider.addressSuggestions.length,
                itemBuilder: (context, index) {
                  final address = authProvider.addressSuggestions[index]['description'];
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    onTap: () {
                      authProvider.pickAddress(address);
                      Navigator.of(context).pop();
                    },
                    title: Text(address),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
