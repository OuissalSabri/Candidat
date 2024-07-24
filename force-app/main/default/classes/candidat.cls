public with sharing class candidat {
    
    @AuraEnabled(cacheable=true)
    public static List<CandidateWrapper> getCandidatesByJobOffer(Id jobOfferId) {
        Set<Id> uniqueCandidateIds = new Set<Id>();
        List<CandidateWrapper> candidates = new List<CandidateWrapper>();

        
        List<Entretien__c> entretiens = [SELECT Id, Candidat__r.Id, Candidat__r.Name, Candidat__r.Adress_email__c, Candidat__r.T_l_phone__c, Candidat__r.Statut__c
                                         FROM Entretien__c
                                         WHERE Offre_Emploi__c = :jobOfferId];

        for (Entretien__c entretien : entretiens) {
            if (!uniqueCandidateIds.contains(entretien.Candidat__r.Id)) {
                candidates.add(new CandidateWrapper(
                    entretien.Candidat__r.Id,
                    entretien.Candidat__r.Name,
                    entretien.Candidat__r.Adress_email__c,
                    entretien.Candidat__r.T_l_phone__c,
                    entretien.Candidat__r.Statut__c
                ));
                uniqueCandidateIds.add(entretien.Candidat__r.Id);
            }
        }

        return candidates;
    }

    public class CandidateWrapper {
        @AuraEnabled public Id candidateId;
        @AuraEnabled public String candidateName;
        @AuraEnabled public String candidateEmail;
        @AuraEnabled public String candidatePhone;
        @AuraEnabled public String candidateStatut;

        public CandidateWrapper(Id candidateId, String candidateName, String candidateEmail, String candidatePhone, String candidateStatut) {
            this.candidateId = candidateId;
            this.candidateName = candidateName;
            this.candidateEmail = candidateEmail;
            this.candidatePhone = candidatePhone;
            this.candidateStatut = candidateStatut;
        }
    }
}
