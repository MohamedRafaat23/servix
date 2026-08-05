import 'package:flutter/material.dart';
import '../../../domain/entites/professional_entity.dart';

class ProfessionalSecondCard extends StatelessWidget {
  final ProfessionalEntity professional;
  final VoidCallback? onTap;

  const ProfessionalSecondCard({
    super.key,
    required this.professional,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 88,
        width: 363, // from CSS width: 363px
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Card background and content
            Container(
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .8),// 0.8 * 255
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.only(left: 14.0, right: 30.0, top: 12.0, bottom: 12.0),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(professional.imageAsset), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          professional.name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF434249),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${professional.profession} · ${professional.distanceMiles} mi',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF91959F),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '★ ${professional.rating} · ${professional.jobsCount} jobs',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFF7CE45),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Price
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${professional.pricePerHour.toInt()}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF368CE1),
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '/hour',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF91959F),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Arrow Button
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .8),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.75),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_outward_rounded, 
                    color: Color(0xFFF97316),
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
