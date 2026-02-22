# AWS Documentation Agent - Examples

## Basic Usage

### Question: S3 Versioning
```bash
kiro-cli chat --agent aws-docs-agent
```

**User:** "How do I enable S3 versioning?"

**Response:**
```markdown
## S3 Bucket Versioning

### Answer

S3 versioning can be enabled through the AWS Console, CLI, or SDK. Once enabled, 
Amazon S3 keeps multiple versions of an object in one bucket, allowing you to 
preserve, retrieve, and restore every version of every object.

### What AWS Documentation Says

[AWS-DOC] "Versioning is a means of keeping multiple variants of an object in 
the same bucket. You can use versioning to preserve, retrieve, and restore every 
version of every object stored in your Amazon S3 bucket."

**Source:** [Using versioning in S3 buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Versioning.html)  
**Section:** What is versioning?

[AWS-DOC] "To enable versioning, you can use the Amazon S3 console, AWS CLI, 
AWS SDKs, or the Amazon S3 REST API."

**Source:** [Enabling versioning on buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/manage-versioning-examples.html)  
**Section:** Enabling versioning

### ⚠️ Important Limitations

All key information is documented above.

For the most current information or specific implementation guidance, review 
the AWS documentation links above, verify in the AWS Console, or open a support 
case with AWS engineers.
```

---

## Complex Question

### Question: Aurora Serverless Versions
**User:** "What's the difference between Aurora Serverless v1 and v2?"

**Response includes:**
- Detailed comparison from official docs
- Multiple [AWS-DOC] citations
- Links to pricing pages
- Clear limitations section if certain details aren't documented

---

## Pricing Question

### Question: Lambda Costs
**User:** "How much does Lambda cost per request?"

**Response includes:**
- Exact pricing from aws.amazon.com/lambda/pricing/
- [AWS-DOC] tags with pricing quotes
- Free tier information
- Links to pricing calculator

---

## Not Found Scenario

### Question: Specific Instance Support
**User:** "Does Database Savings Plan support R5 instances?"

**Response includes:**
- What documentation says about Database Savings Plans
- Explicit statement: "The documentation does not specify which instance families are eligible"
- Links to relevant pricing and documentation pages
- Recommendation to verify with AWS Support

---

## Multi-Source Answer

### Question: RDS MySQL Support
**User:** "Does RDS support MySQL 8.0?"

**Response includes:**
- Quote from RDS FAQ
- Quote from RDS User Guide
- Quote from pricing page
- Multiple [AWS-DOC] citations
- All sources linked

---

## Output Format

Every response follows this structure:

1. **Topic heading**
2. **Answer section** - Direct answer in 2-4 sentences
3. **What AWS Documentation Says** - Exact quotes with [AWS-DOC] tags
4. **Important Limitations** - What's not documented or needs verification

All quotes are:
- Word-for-word from official sources
- Tagged with [AWS-DOC]
- Linked to original documentation
- Include section names for context
